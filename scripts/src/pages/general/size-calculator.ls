/**
 * General page dynamic size calculator
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	jquery: $
	prelude: {map, each, camelize, lists-to-obj, filter, Obj}
	\../../basics : {get-val}
	\../../lib/relative_number.js : relnum
	\../../get-rel-screen-size
}

$w = $ window
$html = $ \html
$body = $html.find \body

headers-n1 = []
headers-n2 = []

$cards = $ \.general-cards
$card-n1 = $cards.find \.card-n1
$card-n1-next = $card-n1.find \.next
$card-n1-next-icon = $card-n1-next.find \>span
headers-n1.push <| $card-n1.find \h1
headers-n2.push <| $card-n1.find \h2

$team = $ \.team
headers-n1.push <| $team.find \h1
headers-n2.push <| $team.find \h2

bind-suffix = \.general-page-size-calculator

widths = \responsive-widths |> get-val
general-page-vals = \general-page |> get-val

get-mb-relval = (min, max) ->
	{screen-w} = get-rel-screen-size!

	relnum do
		rel-val: screen-w
		rel-min: widths.middle
		rel-max: widths.big
		min: min
		max: max

get-rel-vals = (el-key, keys) -->
	{middle, big} = general-page-vals

	get-el-vals = -> it[el-key |> camelize]

	min = middle |> get-el-vals
	max = big |> get-el-vals

	keys
		|> map camelize
		|> map (-> get-mb-relval min[it], max[it])
		|> lists-to-obj (keys |> map camelize)

$w.on "resize#bind-suffix", !->
	let el-key = \next
		let vals = <[ icon-top scale ]>
			vals |>= get-rel-vals el-key
			$card-n1-next-icon.css do
				margin-top: "#{vals.icon-top}px"
				transform: "scale(#{vals.scale})"
		let vals = <[ size margin-top ]>
			vals |>= get-rel-vals el-key
			$card-n1-next.css do
				width: "#{vals.size}px"
				height: "#{vals.size}px"
				border-radius: "#{vals.size / 2}px"
				margin-top: "#{vals.margin-top}px"

	let el-key = \header-n1
		css = <[ font-size line-height ]>
			|> get-rel-vals el-key
			|> Obj.map (+ \px)
		headers-n1 |> each (-> $ it .css css)

	let el-key = \header-n2
		css = <[ font-size line-height padding-top ]>
			|> get-rel-vals el-key
			|> Obj.map (+ \px)
		headers-n2 |> each (-> $ it .css css)

$w.trigger "resize#bind-suffix"

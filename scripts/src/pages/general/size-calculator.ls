/**
 * General page dynamic size calculator
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	jquery: $
	prelude: {map, each, camelize, lists-to-obj, filter, Obj, obj-to-pairs, pairs-to-obj}
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

$portfolio = $ \.portfolio
$portfolio-title-block = $portfolio.find \.title-block
$portfolio-title-block-h2 = $portfolio-title-block.find \h2
$portfolio-title-block-h3 = $portfolio-title-block.find \h3
$portfolio-ul-li = $portfolio.find \>ul>li
$portfolio-ul-li-text = $portfolio-ul-li.find \.text
$portfolio-ul-li-text-h3 = $portfolio-ul-li-text.find \h3
$portfolio-ul-li-text-h4 = $portfolio-ul-li-text.find \h4
$portfolio-ul-li-text-h3-h4 = $portfolio-ul-li-text.find \h3+h4
$portfolio-more-block-a = $portfolio.find \.more-block>a
$portfolio-more-block-a-icon = $portfolio-more-block-a.find 'i.a, i.b'

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
		|> obj-to-pairs
		|> map (-> it.1 = Math.round it.1 unless it.0 is \scale; it)
		|> pairs-to-obj

set-typical-sizes = (el-key, $el) !->
	general-page-vals.big[el-key |> camelize]
		|> Obj.keys
		|> get-rel-vals el-key
		|> Obj.map (+ \px)
		|> $el.css

set-typical-sizes-to-array = (el-key, arr) !->
	css = general-page-vals.big[el-key |> camelize]
		|> Obj.keys
		|> get-rel-vals el-key
		|> Obj.map (+ \px)
	arr |> each (-> $ it .css css)

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

	do
		\header-n1 : headers-n1
		\header-n2 : headers-n2
	|> obj-to-pairs
	|> each (!-> set-typical-sizes-to-array it.0, it.1)

	# portfolio
	do
		\portfolio-title-block : $portfolio-title-block
		\portfolio-title-block-h2 : $portfolio-title-block-h2
		\portfolio-title-block-h3 : $portfolio-title-block-h3
		\portfolio-ul-li : $portfolio-ul-li
		\portfolio-ul-li-text-h3 : $portfolio-ul-li-text-h3
		\portfolio-ul-li-text-h4 : $portfolio-ul-li-text-h4
		\portfolio-ul-li-text-h3-h4 : $portfolio-ul-li-text-h3-h4
		\portfolio-more-block-a : $portfolio-more-block-a
	|> obj-to-pairs
	|> each (!-> set-typical-sizes it.0, it.1)
	let el-key = \portfolio-more-block-a-icon
		let vals = <[ scale ]>
			vals |>= get-rel-vals el-key
			$portfolio-more-block-a-icon.css do
				transform: "translateX(50%) scale(#{vals.scale})"

$w.trigger "resize#bind-suffix"

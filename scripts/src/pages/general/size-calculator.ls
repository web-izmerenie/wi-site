/**
 * General page dynamic size calculator
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	jquery: $
	prelude: {map, each, obj-to-pairs, lists-to-obj}
	\../../basics : {get-val}
	\../../lib/relative_number.js : relnum
	\../../get-rel-screen-size
	\../../size-calc-helpers
}

$w = $ window
$html = $ \html
$body = $html.find \body
$top-part = $body.find \>.top-part

headers-n1 = []
headers-n2 = []

$cards = $ \.general-cards
$cards-list = $cards.children!
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

$header = $body.find \header
$height-helper = $header.find \.height-helper

bind-suffix = \.general-page-size-calculator

widths = \responsive-widths |> get-val
vals-src = \general-page |> get-val
vals = <[middle big]> |> map (-> [vals-src[it]] |> lists-to-obj [it])

get-rel-vals = size-calc-helpers.get-rel-vals vals
set-typical-sizes = size-calc-helpers.set-typical-sizes vals
set-typical-sizes-to-array = size-calc-helpers.set-typical-sizes-to-array vals

$w.on "resize#bind-suffix", !->
	header-offset = $height-helper.height!
	w-h = $w.height!

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

	# team
	$cards-list.css height: w-h
	$team.css height: w-h - header-offset
	$top-part.css height: \auto

$w.trigger "resize#bind-suffix"

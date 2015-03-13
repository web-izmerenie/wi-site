/**
 * General page dynamic size calculator
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	jquery: $
	prelude: {
		map, each, obj-to-pairs, lists-to-obj, Str, pairs-to-obj, Obj, camelize,
	}
	\../../basics : {get-val}
	\../../get-rel-screen-size
	\../../size-calc-helpers
}

$w = $ window
$html = $ \html
$body = $html.find \body
$top-part = $body.find \>.top-part

headers-n1 = []
headers-n2 = []
maps = []

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

$contacts = $ \.contacts
$contacts-head = $contacts.find \.head
$contacts-h2 = $contacts-head.find \h2
$contacts-h2-img = $contacts-h2.find \img
maps.push <| $contacts.find \.map
$contacts-second = $contacts.find \.second
$contacts-cols = $contacts-second.find \.col
$contacts-col-n1 = $contacts-cols.first!
$contacts-col-n2 = $contacts-cols.last!
$contacts-col-n1-phone = $contacts-col-n1.find \.phone
$contacts-col-n1-email = $contacts-col-n1.find \.email
$contacts-col-n1-address = $contacts-col-n1.find \address
contacts-font-n1 =
	$contacts-col-n1-phone
	$contacts-col-n1-email
contacts-font-n2 =
	$contacts-col-n1-address
	...
contacts-col-n1-items =
	$contacts-col-n1-phone
	$contacts-col-n1-email
	$contacts-col-n1-address

$header = $body.find \header
$height-helper = $header.find \.height-helper

bind-suffix = \.general-page-size-calculator

widths = \responsive-widths |> get-val
vals-src = \general-page |> get-val

vals = [<[small middle]> <[middle big]>]
	|> map -> [(it |> map Str.take 1 |> Str.unchars), it]
	|> pairs-to-obj
	|> Obj.map map (-> [vals-src[it]] |> lists-to-obj [it])

calc = <[get-rel-vals set-typical-sizes set-typical-sizes-to-array]>
	|> map camelize
	|> map (-> [it, size-calc-helpers[it]])
	|> pairs-to-obj
	|> Obj.map (-> vals |> Obj.map it)

$w.on "resize#bind-suffix", !->
	{screen-w} = get-rel-screen-size!
	header-offset = $height-helper.height!
	w-h = $w.height!

	range-key = do ->
		| screen-w >= widths.middle => \mb
		| _ => \sm

	let el-key = \next
		let vals = <[icon-top scale]>
			vals |>= calc.get-rel-vals.mb el-key
			$card-n1-next-icon.css do
				margin-top: "#{vals.icon-top}px"
				transform: "scale(#{vals.scale})"
		let vals = <[size margin-top]>
			vals |>= calc.get-rel-vals.mb el-key
			$card-n1-next.css do
				width: "#{vals.size}px"
				height: "#{vals.size}px"
				border-radius: "#{vals.size / 2}px"
				margin-top: "#{vals.margin-top}px"

	do
		\header-n1 : headers-n1
		\header-n2 : headers-n2
	|> obj-to-pairs
	|> each (!-> calc.set-typical-sizes-to-array.mb it.0, it.1)

	do
		\portfolio-title-block : $portfolio-title-block
		\portfolio-title-block-h2 : $portfolio-title-block-h2
		\portfolio-title-block-h3 : $portfolio-title-block-h3
		\portfolio-ul-li : $portfolio-ul-li
		\portfolio-ul-li-text-h3 : $portfolio-ul-li-text-h3
		\portfolio-ul-li-text-h4 : $portfolio-ul-li-text-h4
		\portfolio-ul-li-text-h3-h4 : $portfolio-ul-li-text-h3-h4
		\portfolio-more-block-a : $portfolio-more-block-a
		\contacts-head : $contacts-head
		\contacts-h2 : $contacts-h2
	|> obj-to-pairs
	|> each (!-> calc.set-typical-sizes.mb it.0, it.1)
	let el-key = \portfolio-more-block-a-icon, vals = <[scale]>
		vals |>= calc.get-rel-vals.mb el-key
		$portfolio-more-block-a-icon.css do
			transform: "translateX(50%) scale(#{vals.scale})"

	let el-key = \contacts-h2-img, vals = <[scale]>
		vals |>= calc.get-rel-vals.mb el-key
		$contacts-h2-img.css transform: "scale(#{vals.scale})"

	do
		\contacts-col-n1-items : contacts-col-n1-items
	|> obj-to-pairs
	|> each (!-> calc.set-typical-sizes-to-array.mb it.0, it.1)

	do
		\contacts-second-font-n1 : contacts-font-n1
		\contacts-second-font-n2 : contacts-font-n2
		\contacts-col-n1 : $contacts-col-n1
		\contacts-col-n2 : $contacts-col-n2
	|> obj-to-pairs
	|> each (!-> calc.set-typical-sizes-to-array[range-key] it.0, it.1)

	# team
	$cards-list.css height: w-h
	$team.css height: w-h - header-offset
	$top-part.css height: \auto

	maps |> each (!-> it.trigger \resize-map)

$w.trigger "resize#bind-suffix"

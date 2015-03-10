/**
 * size calculator for footer
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	prelude: {map, each, lists-to-obj, obj-to-pairs}
	jquery: $
	\../basics : {get-val}
	\../lib/relative_number.js : relnum
	\../get-rel-screen-size
	\../size-calc-helpers
}

$w = $ window
$body = $ \body
$footer = $ \footer
$text = $footer.find \.text
$links-block = $footer.find \.footer-links
$prop = $body.find \>.top-part>.prop

bind-suffix = \.footer-size-calc

widths = \responsive-widths |> get-val
vals-src = \footer |> get-val
vals = <[middle big]> |> map (-> [vals-src[it]] |> lists-to-obj [it])

get-rel-vals = size-calc-helpers.get-rel-vals vals
set-typical-sizes = size-calc-helpers.set-typical-sizes vals

$w.on "resize#bind-suffix", !->
	if $body.has-class \loaded then let el-key = \footer, vals = <[ height ]>
		vals |>= get-rel-vals el-key
		$footer.css do
			height: vals.height
			margin-top: -vals.height
		$prop.css height: vals.height

	do
		\links : $links-block
	|> obj-to-pairs
	|> each (!-> set-typical-sizes it.0, it.1)

$w.trigger "resize#bind-suffix"

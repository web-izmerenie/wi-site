/**
 * size calculator for footer
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	prelude: {
		map, each, lists-to-obj, obj-to-pairs, pairs-to-obj, Str, Obj, camelize
	}
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
$text-p = $text.find \>p
$links-block = $footer.find \.footer-links
$prop = $body.find \>.top-part>.prop

bind-suffix = \.footer-size-calc

widths = \responsive-widths |> get-val
vals-src = \footer |> get-val

vals = [<[small middle]> <[middle big]>]
	|> map -> [(it |> map Str.take 1 |> Str.unchars), it]
	|> pairs-to-obj
	|> Obj.map map (-> [vals-src[it]] |> lists-to-obj [it])

calc = <[get-rel-vals set-typical-sizes]>
	|> map camelize
	|> map (-> [it, size-calc-helpers[it]])
	|> pairs-to-obj
	|> Obj.map (-> vals |> Obj.map it)

$w.on "resize#bind-suffix", !->
	{screen-w} = get-rel-screen-size!

	if $body.has-class \loaded then let el-key = \footer, vals = <[height]>
		vals |>= calc.get-rel-vals.mb el-key
		$footer.css do
			height: vals.height
			margin-top: -vals.height
		$prop.css height: vals.height

	do
		\links : $links-block
		\copyright-text-p : $text-p
	|> obj-to-pairs
	|> each (!-> calc.set-typical-sizes.mb it.0, it.1)

	range-key = do ->
		| screen-w >= widths.middle => \mb
		| _ => \sm

	do
		\copyright-text-block : $text
	|> obj-to-pairs
	|> each (!-> calc.set-typical-sizes[range-key] it.0, it.1)

$w.trigger "resize#bind-suffix"

/**
 * General page cards size calculator
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	jquery: $
	prelude: {map, each, Str, pairs-to-obj, Obj, lists-to-obj, camelize}
	\../../../basics : {get-val}
	\../../../get-rel-screen-size
	\../../../size-calc-helpers
}

$w = $ window

s-class     = \cards-switcher
bind-suffix = \.cards-switcher

# get values
widths      = \responsive-widths |> get-val
vals-src    = \general-page |> get-val

vals = [<[extra-small small]> <[small middle]> <[middle big]>]
	|> map -> [(it |> map Str.take 1 |> Str.unchars), (it |> map camelize)]
	|> pairs-to-obj
	|> Obj.map map (-> [vals-src[it]] |> lists-to-obj [it])

calc = <[get-rel-vals]>
	|> map camelize
	|> map (-> [it, size-calc-helpers[it]])
	|> pairs-to-obj
	|> Obj.map (-> vals |> Obj.map it)

on-resize = ({$cards-switcher})!->

	{screen-w} = get-rel-screen-size!

	range-key = do ->
		| screen-w >= widths.small  => \sm
		| screen-w >= widths.middle => \mb
		| otherwise                 => \es

	let el-name = \cards-switcher, vals = <[width bottom]>
		vals |>= calc.get-rel-vals[range-key] el-name
		$cards-switcher
			.attr width: vals.width
			.css bottom: "#{vals.bottom}px"

	# calc active line opacity and delegate to switcher module

	$cards-switcher.trigger "newsize#bind-suffix"

export init = (cb)!->

	$cards-wrap     = $ \.general-cards
	$controls       = $cards-wrap.find \.controls
	$cards-switcher = $controls.find "svg.#{s-class}"

	# bind on page resize
	$w.on "resize#bind-suffix", (on-resize.bind null, {$cards-switcher})

	cb!

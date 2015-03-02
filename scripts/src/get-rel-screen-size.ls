/**
 * @author Viacheslav Lotsmanov
 */

require! {
	jquery: $
	\./basics : {get-val}
}

ratio = get-val \workspace-ratio

$w = $ window

module.exports = ->
	# get screen size
	screen-w = $w.width!
	screen-h = $w.height!

	# dependence on a ratio
	#test-h = screen-w |> (* ratio.1) |> (/ ratio.0)
	#screen-w = screen-h |> (* ratio.0) |> (/ ratio.1) if test-h > screen-h

	{screen-w, screen-h}

/**
 * recalculating header size by workspace size
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	prelude: {map, camelize, lists-to-obj, reject, each, Obj, obj-to-pairs, pairs-to-obj}
	jquery: $
	\../basics : {get-val}
	\../lib/relative_number.js : relnum
	\../get-rel-screen-size
}

$w = $ window
$html = $ \html
$head = $html.find \head
$body = $html.find \body
$header = $body.find \header
$height-helper = $header.find \.height-helper
$fixed-header = $header.find \.fixed-header
$bg-helper = $fixed-header.find \.bg-helper

$all-logos = $header.find \.logo
$card-n1-logo = $header.find \>.logo
$logo = $all-logos .not $card-n1-logo

$all-logos-text = $all-logos.find \.logo-text
$all-logos-img = $all-logos.find \.logo-image
$logo-text = $logo.find \.logo-text

$call-menu = $header.find \.call-menu
$menu = $header.find \.menu
$nav = $menu.find \nav
$nav-links = $nav.find \a
$nav-items = $nav.find '>a, >span'

bind-suffix = \.header-size-calc

# get values
widths = \responsive-widths |> get-val
sizes = \header |> get-val
speed = \animation-speed |> get-val |> (* 2)

get-header-vals = ({helper=false, fixed-header=false})->
	{screen-w} = get-rel-screen-size!
	relnum-opts =
		rel-val: screen-w
		rel-min: widths.middle
		rel-max: widths.big

	height = do ->
		| screen-w >= widths.middle =>
			Math.round relnum ^^relnum-opts <<<<
				min: sizes.middle.height
				max: sizes.big.height
		| screen-w >= widths.small => sizes.middle.height
		| helper => sizes.small.helper-height
		| fixed-header => \100%
		| _ => sizes.small.height

	width = if screen-w <= widths.small then sizes.small.width else \100%
	width = \100% if fixed-header

	{width, height}

get-logo-vals = ->
	{screen-w} = get-rel-screen-size!
	relnum-opts =
		rel-val: screen-w
		rel-min: widths.middle
		rel-max: widths.big

	size = do ->
		| screen-w >= widths.middle =>
			Math.round relnum ^^relnum-opts <<<<
				min: sizes.middle.logo.size
				max: sizes.big.logo.size
		| screen-w >= widths.small =>
			Math.round relnum ^^relnum-opts <<<<
				rel-min: widths.small
				rel-max: widths.middle
				min: sizes.small.logo.size
				max: sizes.middle.logo.size
		| _ => sizes.small.logo.size

	left = sizes.all.logo.left

	top-min = sizes.middle.height |> (- sizes.middle.logo.size) |> (/ 2)
	top-max = sizes.big.height |> (- sizes.big.logo.size) |> (/ 2)
	top = Math.round relnum ^^relnum-opts <<<<
		min: top-min
		max: top-max

	text-val = (key)->
		| screen-w >= widths.middle =>
			Math.round relnum ^^relnum-opts <<<<
				min: sizes.middle.logo.text[key]
				max: sizes.big.logo.text[key]
		| screen-w >= widths.small =>
			Math.round relnum ^^relnum-opts <<<<
				rel-min: widths.small
				rel-max: widths.middle
				min: sizes.small.logo.text[key]
				max: sizes.middle.logo.text[key]
		| _ => sizes.small.logo.text[key]

	keys = <[ margin-left font-size line-height ]> |> map camelize
	text = keys |> map text-val |> lists-to-obj keys

	{size, left, top, text}

get-call-menu-vals = ->
	{screen-w} = get-rel-screen-size!
	relnum-opts =
		rel-val: screen-w
		rel-min: widths.middle
		rel-max: widths.big

	val-calc = (key)->
		| screen-w >= widths.middle =>
			relnum ^^relnum-opts <<<<
				min: sizes.middle.call-menu[key]
				max: sizes.big.call-menu[key]
		| screen-w >= widths.small =>
			relnum ^^relnum-opts <<<<
				rel-min: widths.small
				rel-max: widths.middle
				min: sizes.small.call-menu[key]
				max: sizes.middle.call-menu[key]
		| _ => sizes.small.call-menu[key]

	keys = <[ right top scale ]> |> map camelize
	keys
		|> map val-calc
		|> lists-to-obj keys
		|> obj-to-pairs
		|> map (-> it.1 = Math.round it.1 unless it.0 is \scale; it)
		|> pairs-to-obj

get-nav-vals = ->
	{screen-w} = get-rel-screen-size!
	relnum-opts =
		rel-val: screen-w
		rel-min: widths.middle
		rel-max: widths.big
	res = {}

	val-calc = (key)->
		| screen-w >= widths.middle =>
			Math.round relnum ^^relnum-opts <<<<
				min: sizes.middle.nav[key]
				max: sizes.big.nav[key]
		| screen-w >= widths.small => sizes.middle.nav[key]
		| _ => sizes.small.nav[key]
	keys = <[ right ]> |> map camelize
	res <<<< (keys |> map val-calc |> lists-to-obj keys)

	top = do ->
		| screen-w >= widths.middle => sizes.big.nav.top
		| screen-w >= widths.small => sizes.middle.nav.top
		| _ => sizes.small.nav.top

	item-calc = (key)->
		| screen-w < widths.small and key is (\padding-top |> camelize) => ''
		| screen-w >= widths.middle =>
			Math.round relnum ^^relnum-opts <<<<
				min: sizes.middle.nav.item[key]
				max: sizes.big.nav.item[key]
		| screen-w >= widths.small => sizes.middle.nav.item[key]
		| _ => sizes.small.nav.item[key]

	keys = <[ font-size padding-top ]> |> map camelize
	item = keys |> map item-calc |> lists-to-obj keys

	res <<<< {top, item}

$header.on \menu-state-changed, !->
	return unless $body.has-class \loaded

	{screen-w} = get-rel-screen-size!
	last-class = $header.data \last-size-class
	cur-class = $body.data \size-class

	# horizontal
	if screen-w >= widths.small
		menu-reset =
			min-width: ''
			max-width: ''
			width: ''

		if $header.has-class \menu-active or $header.has-class \scroll-menu-active
			css = height: $height-helper.height!
		else
			css = height: 0

		if last-class isnt cur-class
			$menu.stop!.css menu-reset .css css
			$fixed-header.stop!.css css
		else
			$menu.stop!.css menu-reset .transition css, speed
			$fixed-header.stop!.transition css, speed

	# vertical
	else
		menu-reset =
			height: \100%
			min-width: 0
			max-width: sizes.small.width

		$fixed-header.css width: ''

		if $header.has-class \menu-active
			css = width: sizes.small.width
		else
			css = width: 0

		if last-class isnt cur-class
			$menu.stop!.css menu-reset .css css
			$fixed-header.stop!.css css
		else
			$menu.stop!.css menu-reset .transition css, speed
			$fixed-header.stop!.transition css

	if last-class isnt cur-class
		$header.data \last-size-class cur-class

# scroll handler
$w.on "scroll#bind-suffix" !->
	return unless $body.has-class \loaded

	logo-vals = get-logo-vals!
	$card-n1-logo.css do
		top: "#{logo-vals.top}px"
		left: "#{logo-vals.left}px"
	$call-menu.css margin-top: 0

	{screen-w} = get-rel-screen-size!

	if $header.has-class \scroll-menu-active
		if screen-w >= widths.small
			$bg-helper.css height: $height-helper.height!
		else
			$bg-helper.css height: sizes.small.helper-height
			$card-n1-logo.css do
				left: "#{sizes.small.logo.scroll.left}px"
				top: "#{sizes.small.logo.scroll.top}px"
			$call-menu.css margin-top: "#{sizes.small.call-menu.margin-top}px"
	else
		$bg-helper.css height: ''

	$header.trigger \menu-state-changed

	# hide logo text if not enough header width
	switch
	| screen-w >= widths.small =>
		ls = $logo.width! + $logo.offset!.left
		ms = $nav.width! + (($nav.css \right |> parse-int _, 10) or 0)
		if $header.width! - ls - ms <= 15
			$logo.add-class \no-text
		else
			$logo.remove-class \no-text
	| _ => $logo.remove-class \no-text

normal-screen-reset = !->
	$fixed-header.css do
		left: 0
		right: \auto
		max-width: ''
		min-width: ''
	$logo.css display: ''

update-size-class = (size-code)!->
	sizes = <[ small middle big ]>
	size-class-f = (+ \-size)

	sizes |> reject (is size-code)
		|> map size-class-f
		|> each ($body.remove-class _)

	[size-code]
		|> map size-class-f
		|> each ($body.add-class _)
		|> each ($body.data \size-class _)

# resize handler
$w.on "resize#bind-suffix" !->
	return unless $body.has-class \loaded

	{screen-w, screen-h} = get-rel-screen-size!

	normal-screen-reset! if screen-w >= widths.small

	fixed-header = get-header-vals fixed-header: true
	header-helper = get-header-vals helper: true
	logo-vals = get-logo-vals!
	call-menu-vals = get-call-menu-vals!
	nav-vals = get-nav-vals!

	relnum-opts = rel-val: screen-w

	# between middle and big and more than big
	if screen-w >= widths.middle
		update-size-class \big

	# between small and middle
	else if screen-w >= widths.small
		update-size-class \middle

	# small screen and smaller
	else
		update-size-class \small
		$fixed-header.css do
			left: \auto
			right: 0
			max-width: fixed-header.width
			min-width: 0
		$logo.css display: \none

	$height-helper.css height: header-helper.height
	$fixed-header.css do
		width: fixed-header.width
		height: fixed-header.height

	# logos
	$logo.css do
		left: logo-vals.left
		top: logo-vals.top
	$all-logos-img.css do
		width: "#{logo-vals.size}px"
		height: "#{logo-vals.size}px"
	$all-logos-text.css do
		margin-left: "#{logo-vals.text.margin-left}px"
		font-size: "#{logo-vals.text.font-size}px"
		line-height: "#{logo-vals.text.line-height}px"

	# call menu button
	$call-menu.css do
		right: "#{call-menu-vals.right}px"
		top: "#{call-menu-vals.top}px"
		transform: "scale(#{call-menu-vals.scale})"

	# nav
	$nav.css do
		right: "#{nav-vals.right}px"
		top: nav-vals.top
	$nav-items.css do
		font-size: "#{nav-vals.item.font-size}px"
		line-height: "#{nav-vals.item.font-size + 2}px"
		padding-top: nav-vals.item.padding-top

	$header
		.css height: \auto
		.trigger \menu-state-changed

	$w.trigger "scroll#bind-suffix"

module.exports = {
	get-header-vals
	get-logo-vals
}

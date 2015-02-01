/**
 * recalculating header size by workspace size
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	prelude: _p
	jquery: $
	'../basics': b
	'../lib/relative_number.js': relnum
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
$card1-logo = $header.find \>.logo
$logo = $all-logos .not $card1-logo

$all-logos-text = $all-logos.find \.logo-text
$all-logos-img = $all-logos.find \.logo-image

$call-menu = $header.find \.call-menu
$menu = $header.find \.menu
$nav = $menu.find \nav
$nav-links = $nav.find \a

bind-suffix = '.header-size-calc'

# get values
widths = b.get-val \responsive-widths
ratio = b.get-val \workspace-ratio
sizes = b.get-val \header
speed = (b.get-val \animation-speed) * 2

get-rel-screen-size = ->
	# get screen size
	screen-w = $w.width!
	screen-h = $w.height!

	# dependence on a ratio
	#test-h = screen-w * ratio.1 / ratio.0
	#screen-w = screen-h * ratio.0 / ratio.1 if test-h > screen-h

	{screen-w, screen-h}

get-header-vals = ({helper=false, fixed-header=false})->
	{screen-w} = get-rel-screen-size!
	relnum-opts =
		rel-val: screen-w
		rel-min: widths.middle
		rel-max: widths.big

	height = do ->
		| screen-w >= widths.middle =>
			relnum ^^relnum-opts <<<<
				min: sizes.middle.height
				max: sizes.big.height
		| screen-w > widths.small => sizes.middle.height
		| helper => sizes.small.helper-height
		| fixed-header => \100%
		| _ => sizes.small.height

	width = if screen-w <= widths.small then sizes.small.width else \100%

	{width, height}

get-logo-vals = ->
	{screen-w} = get-rel-screen-size!
	relnum-opts =
		rel-val: screen-w
		rel-min: widths.middle
		rel-max: widths.big

	size = do ->
		| screen-w >= widths.middle =>
			relnum ^^relnum-opts <<<<
				min: sizes.middle.logo.size
				max: sizes.big.logo.size
		| screen-w >= widths.small =>
			relnum ^^relnum-opts <<<<
				rel-min: widths.small
				rel-max: widths.middle
				min: sizes.small.logo.size
				max: sizes.middle.logo.size
		| _ => sizes.small.logo.size

	left = sizes.all.logo.left

	top-min = (sizes.middle.height - sizes.middle.logo.size) / 2
	top-max = (sizes.big.height - sizes.big.logo.size) / 2
	top = relnum ^^relnum-opts <<<<
		min: top-min
		max: top-max

	text-val = (key)->
		key |>= _p.camelize
		do ->
			| screen-w >= widths.middle =>
				relnum ^^relnum-opts <<<<
					min: sizes.middle.logo.text[key]
					max: sizes.big.logo.text[key]
			| screen-w >= widths.small =>
				relnum ^^relnum-opts <<<<
					rel-min: widths.small
					rel-max: widths.middle
					min: sizes.small.logo.text[key]
					max: sizes.middle.logo.text[key]
			| _ => sizes.small.logo.text[key]

	text =
		margin-left: text-val \margin-left
		font-size: text-val \font-size
		line-height: text-val \line-height

	{size, left, top, text}

get-call-menu-vals = ->
	{screen-w} = get-rel-screen-size!
	relnum-opts =
		rel-val: screen-w
		rel-min: widths.middle
		rel-max: widths.big

$header.on \menu-state-changed, !->
	return unless $body.has-class \loaded

	{screen-w} = get-rel-screen-size!

	# horizontal
	if screen-w > widths.small
		reset =
			min-width: ''
			max-width: ''
			width: ''
		if $header.has-class \menu-active
			$menu.stop!.css reset
				.transition height: $fixed-header.height!, speed
		else
			$menu.stop!.css reset
				.transition height: 0, speed

	# vertical
	else
		reset =
			height: \100%,
			min-width: 0,
			max-width: sizes.small.width
		if $header.has-class \menu-active
			$menu.stop!.css reset
				.transition width: sizes.small.width, speed
		else
			$menu.stop!.css reset
				.transition width: 0, speed

# scroll handler
$w.on "scroll#bind-suffix" !->
	return unless $body.has-class \loaded

	if $header.has-class \scroll-menu-active
		{screen-w} = get-rel-screen-size!

		if screen-w >= widths.small
			$bg-helper.css height: $fixed-header.height!
		else
			$bg-helper.css height: sizes.small.helper-height
	else
		$bg-helper.css height: ''

normal-screen-reset = !->
	$fixed-header.css do
		left: 0
		right: \auto
		max-width: ''
		min-width: ''
	$logo.css display: ''

# resize handler
$w.on "resize#bind-suffix" !->
	return unless $body.has-class \loaded

	{screen-w, screen-h} = get-rel-screen-size!

	header-w = \100%

	normal-screen-reset! if screen-w >= widths.small

	fixed-header = get-header-vals fixed-header: true
	header-helper = get-header-vals helper: true
	logo-vals = get-logo-vals!

	relnum-opts = rel-val: screen-w

	# between middle and big and more than big
	if screen-w >= widths.middle
		void

	# between small and middle
	else if screen-w >= widths.small
		void

	# small screen and smaller
	else
		$fixed-header.css do
			left: \auto
			right: 0
			max-width: fixed-header.width
			min-width: 0
		$logo.css display: \none

	# logos
	$logo.css do
		left: logo-vals.left
		top: logo-vals.top
	$all-logos-img.css do
		width: logo-vals.size + \px
		height: logo-vals.size + \px
	$all-logos-text.css do
		margin-left: logo-vals.text.margin-left + \px
		font-size: logo-vals.text.font-size + \px
		line-height: logo-vals.text.line-height + \px

	$height-helper.css height: header-helper.height
	$fixed-header.css do
		width: fixed-header.width
		height: fixed-header.height
	$header
		.css height: \auto
		.trigger \menu-state-changed

	$w.trigger "scroll#bind-suffix"

module.exports = {
	get-header-vals
	get-logo-vals
}

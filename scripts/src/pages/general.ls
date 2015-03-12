/**
 * General page behavior
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	prelude: {is-type}
	jquery: $
	\../basics : {get-val, get-local-text, load-img}
	\../preload
	\../link-handler
	\../has-el-by-hash
	\../header/size-calculator
	\./general/scroll-restore : {bind-before, bind-after}
}

require \jquery.transit

$w = $ window
$html = $ \html
$page = $ 'html, body'

$body = $html.find \body
$header = $body.find \header
$logo = $header.find \>.logo
$logo-img = $logo.find \img

$cards = $ \.general-cards
$card-n1 = $cards.find \.card-n1
$card-n1-bg = $card-n1.find \.bg
$card-n1-next = $card-n1.find \.next

speed = get-val \animation-speed |> (* 4)
logo-vals = size-calculator.get-logo-vals!

loading-animation = true

bind-before!

$card-n1-next.click link-handler

card-n1-parallax-init = !->
	card-n1-bg-parallax-bind-suffix = \.card-n1-bg-parallax

	$w.on "scroll#{card-n1-bg-parallax-bind-suffix}", !->
		st = $w.scroll-top!
		return if st > $card-n1.height!
		val = st / 2
		$card-n1-bg.css \background-position, "center #{val}px"

	$w.on "resize#{card-n1-bg-parallax-bind-suffix}", !->
		$w.trigger "scroll#{card-n1-bg-parallax-bind-suffix}"

	$w.trigger "resize#{card-n1-bg-parallax-bind-suffix}"

# rotate Wi logo before finish loading
loading-loop = !->
	return unless loading-animation
	$logo-img.transition rotate: \360deg, speed, \linear, !->
		return unless loading-animation
		$logo-img.css rotate: \0deg
		loading-loop!

# callback after all images is preloaded (see icons.styl)
preload-cb = !->
	card-n1-parallax-init!
	loading-animation := false
	<-! $logo-img.stop!.transition rotate: \360deg, speed, \linear
	<-! $card-n1-bg.stop!.transition opacity: 1, scale: 1, speed, \in-out
	$logo.add-class \logo-move
	vals =
		left: logo-vals.left
		top: logo-vals.top
		translate: [\0%,\0%]
	<-! $logo.stop!.transition vals, speed, \in-out

	$body .add-class \loaded
	$page .scroll-top 0

	require! {
		\./general/size-calculator : {}
		\./general/portfolio : {}
		\./general/team : {}
	}
	$w
		.trigger \resize.header-size-calc
		.trigger \resize
	bind-after!

	go-to-anchor = $html.data \go-to-anchor
	go-to-anchor! if go-to-anchor |> is-type \Function

# preload logo first (for use this logo as loading spinner)

$logo-img.css do
	width: logo-vals.size
	height: logo-vals.size

require! \../lib/load_img : LoadImg # for get exceptions (need to refactoring this module in the future)
img-src = $logo-img.attr \src
(err, img) <-! load-img img-src

if err
	if err instanceof LoadImg.exceptions.Timeout
		window.alert get-local-text \err, \preload-img-timeout, do
			\#IMAGE_SRC# : img-src
		return
	window.alert get-local-text \err, \preload-img, do
		\#ERROR_CODE# : err.to-string!
		\#IMAGE_SRC# : img-src
	return

loading-loop!
preload preload-cb

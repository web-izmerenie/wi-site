/**
 * General page behavior
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	prelude: {is-type}
	jquery: $
	\../basics : {get-val, get-local-text, load-img, dynamic-api}
	\../preload
	\../link-handler
	\../has-el-by-hash
	\../header/size-calculator
	\./general/scroll-restore : {bind-before, bind-after}
	\./general/contacts : {get-yandex-maps-api-url}
	\jquery.transit : {}
}

const $w    = $ window
const $html = $ \html
const $page = $ 'html, body'

const $body     = $html.find \body
const $header   = $body.find \header
const $logo     = $header.find \>.logo
const $logo-img = $logo.find \img

const $cards-wrap   = $body.find \.general-cards
const $cards-bgs    = $cards-wrap.find \.backgrounds
const $card-n0      = $cards-wrap.find \.card-n0
const $card-n0-bg   = $cards-bgs.find '.card-bg-n0 .bg-pattern'
const $card-n0-next = $card-n0.find \.next

const speed = get-val \animation-speed |> (* 4)
const logo-vals = size-calculator.get-logo-vals!

loading-animation = true # mutable

bind-before!

# start this callback after all preparations
init-all-other-sections = !->
	$body .add-class \loaded
	$page .scroll-top 0

	require! {
		\./general/size-calculator : {}
		\./general/cards/cards : {init: cards-init}
		\./general/portfolio : {}
		\./general/team : {}
		\./general/reviews : {}
		\./general/contacts : {init: contacts-init}
	}
	<-! cards-init
	contacts-init!
	$w
		.trigger \resize.header-size-calc
		.trigger \resize
	bind-after!

	go-to-anchor = $html.data \go-to-anchor
	go-to-anchor! if go-to-anchor |> is-type \Function

$card-n0-next.click link-handler

card-n0-parallax-init = !->
	card-n0-bg-parallax-bind-suffix = \.card-n0-bg-parallax

	$w.on "scroll#{card-n0-bg-parallax-bind-suffix}", !->
		st = $w.scroll-top!
		return if st > $card-n0.height!
		val = st / 2
		$card-n0-bg.css \background-position, "center #{val}px"

	$w.on "resize#{card-n0-bg-parallax-bind-suffix}", !->
		$w.trigger "scroll#{card-n0-bg-parallax-bind-suffix}"

	$w.trigger "resize#{card-n0-bg-parallax-bind-suffix}"

card-n0-next-button-jitter-init = !->
	speed = 800
	wait = 5000
	jitter = !->
		$card-n0-next.css top: 0
		<-! set-timeout _, wait
		<-! $card-n0-next.stop!.transition top: \-30px, speed
		<-! $card-n0-next.stop!.transition top: 0px, speed
		jitter!
	jitter!

# rotate Wi logo before finish loading
loading-loop = !->
	return unless loading-animation
	$logo-img.transition rotate: \360deg, speed, \linear, !->
		return unless loading-animation
		$logo-img.css rotate: \0deg
		loading-loop!

# callback after all images is preloaded (see icons.styl)
preload-cb = !->
	card-n0-parallax-init!
	card-n0-next-button-jitter-init!

	loading-animation := false
	<-! $logo-img.stop!.transition rotate: \360deg, speed, \linear
	<-! $card-n0-bg.stop!.transition opacity: 1, scale: 1, speed, \in-out
	$logo.add-class \logo-move
	vals =
		left: logo-vals.left
		top: logo-vals.top
		translate: [\0%,\0%]
	$logo.stop!.transition vals, speed, \in-out, init-all-other-sections

# preload logo first (for use this logo as loading spinner)

$logo-img.css do
	width: logo-vals.size
	height: logo-vals.size

require! \load-img : LoadImg # for get exceptions (need to refactoring this module in the future)
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

loading-loop! # run loading animation asynchonusly

# start preload images and after that - "preload-db"
preload preload-cb

/**
 * General page behavior
 *
 * @author Viacheslav Lotsmanov
 * @license GNU/AGPLv3
 * @see {@link https://github.com/web-izmerenie/wi-site/blob/master/LICENSE-AGPLv3|License}
 */

require! {
	jquery : $
	'../basics' : b
	'../preload'
}

require \jquery.transit

$w = $ window
$html = $ \html

$body = $html .find \body
$header = $body .find \header
$logo = $header .find '>.logo'
$logo-img = $logo .find \img

$cards = $ \.general-cards
$card1 = $cards .find \.card-1
$card1-bg = $card1 .find \.bg
$card1-next = $card1 .find \.next

speed = b.get-val \animation-speed

loading-animation = true

$card1-next .click ->
	false

loading-loop = !->
	if not loading-animation then return
	$logo-img.transition rotate: \360deg, (speed*4), \linear, !->
		if not loading-animation then return
		$logo-img.css rotate: \0deg
		loading-loop!

preload-cb = !->
	loading-animation := false
	<-! $logo-img .stop! .transition rotate: \360deg, (speed*4), \linear
	<-! $card1-bg .stop! .transition opacity: 1, scale: 1, (speed*4), \in-out
	$logo .addClass \logo-move
	set-timeout (!-> $body .addClass \loaded), (speed*4)

	# card-1 background parallax

	card1-bg-parallax-bind-suffix = '.card-1-bg-parallax'

	$w.on \scroll + card1-bg-parallax-bind-suffix, !->
		st = $w.scrollTop!
		return if st > $card1.height!
		val = st / 2
		$card1-bg.css \background-position, "center #{val}px"

	$w.on \resize + card1-bg-parallax-bind-suffix, !->
		$w.trigger \scroll + card1-bg-parallax-bind-suffix

	$w.trigger \resize + card1-bg-parallax-bind-suffix

# preload logo

require! '../lib/load_img' : LoadImg
img-src = $logo-img.attr \src
b.load-img img-src, (err, img) !->
	if err
		if err instanceof LoadImg.exceptions.Timeout
			window.alert b.get-local-text \err, \preload-img-timeout, {
				\#IMAGE_SRC# : img-src
			}
			return
		window.alert b.get-local-text \err, \preload-img, {
			\#ERROR_CODE# : err.to-string!
			\#IMAGE_SRC# : img-src
		}
		return

	loading-loop!
	preload preload-cb

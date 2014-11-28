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

$body = $ \body
$header = $body .find \header
$logo = $header .find \.logo
$logo-img = $logo .find \img
$logo-text = $logo .find \.logo-text
$call-menu = $header .find \.call-menu
$menu = $header .find \.menu

$cards = $ \.general-cards
$card1 = $cards .find \.card-1
$card1-bg = $card1 .find \.bg
$card1-next = $card1 .find \.next

speed = b.get-val \animation-speed

loading-animation = true

timer = !->
	if not loading-animation then return
	$logo-img.transition rotate: \360deg, speed, \linear, !->
		if not loading-animation then return
		$logo-img.css rotate: \0deg
		timer!
timer!

interface-ready = false

$logo .click ->
	false

$call-menu .click ->
	if not interface-ready then false

	if $header .hasClass \menu-active
		$header .removeClass \menu-active
	else
		$header .addClass \menu-active

	false

$card1-next .click ->
	false

preload !->
	loading-animation := false
	<-! $logo-img .stop! .transition rotate: \360deg, (speed * 4), \linear
	<-! $card1-bg .stop! .transition opacity: 1, scale: 1, (speed * 4), \in-out
	$logo .addClass \logo-move
	set-timeout (!->
		$body .addClass \loaded
		interface-ready := true
	), (speed * 4)

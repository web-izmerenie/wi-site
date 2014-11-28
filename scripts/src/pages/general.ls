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

$cards = $ \.general-cards
$card1 = $cards.find \.card-1

$header = $ \header
$logo = $ \.logo
$logo-img = $logo.find \img

speed = (b.get-val \animation-speed) * 4
curve = \linear

loading-animation = true

timer = !->
	if not loading-animation then return
	$logo-img.transition rotate: \360deg, speed, curve, !->
		if not loading-animation then return
		$logo-img.css rotate: \0deg
		timer!
timer!

preload !->
	loading-animation := false
	$logo-img .stop! .transition rotate: \0deg, speed, curve, !->
		void

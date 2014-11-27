/**
 * General page behavior
 *
 * @author Viacheslav Lotsmanov
 * @license GNU/AGPLv3
 * @see {@link https://github.com/web-izmerenie/wi-site/blob/master/LICENSE-AGPLv3|License}
 */

require! {
	prelude : _p
	jquery : $
	'../basics'
}

require \jquery.transit

$cards = $ \.general-cards
$card1 = $cards.find \.card-1

$header = $ \header
$logo = $ \.logo
$logo-img = $logo.find \img

speed = (basics.get-val \animation-speed) * 4
curve = \linear

# page loading

timer = !->
	$logo-img.transition rotate: \360deg, speed, curve, !->
		$logo-img.css rotate: \0deg
		timer!

timer!

/**
 * show or hide header block by scroll
 *
 * @author Viacheslav Lotsmanov
 */

require! jquery: $

$w = $ window

$html = $ \html
$body = $html.find \body
$header = $body.find \header
$height-helper = $header.find \.height-helper
$cards = $ \.main-card

main-page = $html.has-class \general-page

# for other pages use fixed header always
unless main-page
	$header.add-class \scroll-menu-active
	return

bind-suffix = \.header-menu-show-after-cards

scroll-handler = !->
	st = $w.scroll-top! + $height-helper.height!
	if st >= $cards.height!
		$header.add-class \scroll-menu-active
	else
		$header.remove-class \scroll-menu-active

$w
	.on "scroll#{bind-suffix}", scroll-handler
	.on "resize#{bind-suffix}", scroll-handler

scroll-handler!

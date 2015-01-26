/**
 * Header
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	jquery : $
	'../link-handler'
}

$html = $ \html

$body = $html.find \body
$header = $body.find \header
$logo = $header.find '.logo'
$call-menu = $header.find \.call-menu
$menu = $header.find \.menu
$nav = $menu.find \nav
$nav-links = $nav.find \a

main-page = $html.hasClass \general-page

$logo.click link-handler

# show/hide menu
$call-menu.click ->
	return false if main-page and not $body.has-class \loaded

	if $header.has-class \menu-active
		$header.remove-class \menu-active
	else
		$nav.css \top ''
		$header.add-class \menu-active

	false

$nav-links.click link-handler

require './menu-vertical-scroll'
require './fixed-header-block'
require './anchor-detector'

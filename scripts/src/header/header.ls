/**
 * Header
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	jquery: $
	\../basics : {get-val}
	\../link-handler
}

$html = $ \html

$body = $html.find \body
$header = $body.find \header
$logo = $header.find \.logo
$call-menu = $header.find \.call-menu
$menu = $header.find \.menu
$nav = $menu.find \nav
$nav-links = $nav.find \a

main-page = $html.has-class \general-page

sizes = get-val \header

$logo.click link-handler

$helper = $ \<div/>, class: \centering-helper
$nav.append $helper

# show/hide menu
$call-menu.click ->
	return false if main-page and not $body.has-class \loaded

	if $header.has-class \menu-active
		$header.remove-class \menu-active
	else
		$nav.css \top, ''
		$header.add-class \menu-active

	$header.trigger \menu-state-changed

	false

$nav-links.click link-handler

require! {
	\./fixed-header-block : {}
	\./anchor-detector : {}
	\./size-calculator : {}
}

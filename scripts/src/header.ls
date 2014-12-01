/**
 * Header
 *
 * @author Viacheslav Lotsmanov
 * @license GNU/AGPLv3
 * @see {@link https://github.com/web-izmerenie/wi-site/blob/master/LICENSE-AGPLv3|License}
 */

require! {
	jquery : $
	'./basics' : b
	'./link-handler'
}

$w = $ window
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
	return false if main-page and not $body.hasClass \loaded

	if $header.hasClass \menu-active
		$header.removeClass \menu-active
	else
		$nav.css \top ''
		$header.addClass \menu-active

	false

$nav-links.click link-handler

handler-bind-suffix = \.header-handler

resize-handler = !->
	if $nav.innerHeight! <= $w.height!
		$nav
			.removeClass \scroll
			.css \top ''
		return \no-scroll

	$nav.addClass \scroll

last-scroll-top = $w.scrollTop! # store last scroll top value for calculate scroll for vertical menu
scroll-handler = !-> # support vertical scroll for narrow screens vertical menu
	return if resize-handler! is \no-scroll

	st = $w.scrollTop!
	top = parse-int ($nav.css \top), 10
	h = $nav.innerHeight!
	wh = $w.height!

	new-top = (top - (st - last-scroll-top))

	ws = -(h - wh)
	new-top = 0 if new-top > 0
	new-top = ws if new-top < ws

	$nav.css \top new-top + \px

	last-scroll-top := st

$w
	.on \scroll + handler-bind-suffix, scroll-handler
	.on \resize + handler-bind-suffix, resize-handler

scroll-handler!

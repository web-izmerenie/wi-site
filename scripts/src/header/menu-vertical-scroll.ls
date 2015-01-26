/**
 * main menu vertical scroll for narrow screens
 *
 * @author Viacheslav Lotsmanov
 */

require! jquery : $

$w = $ window

$html = $ \html
$body = $html.find \body
$header = $body.find \header
$menu = $header.find \.menu
$nav = $menu.find \nav

bind-suffix = \.header-menu-vertical-scroll

resize-handler = !->
	if $nav.inner-height! <= $w.height!
		$nav
			.removeClass \scroll
			.css \top ''
		return \no-scroll

	$nav.add-class \scroll

# store last scroll top value for calculate scroll for vertical menu
last-scroll-top = $w.scroll-top!

# support vertical scroll for narrow screens vertical menu
scroll-handler = !->
	return if resize-handler! is \no-scroll

	st = $w.scroll-top!
	top = parse-int ($nav.css \top), 10
	h = $nav.inner-height!
	wh = $w.height!

	new-top = (top - (st - last-scroll-top))

	ws = -(h - wh)
	new-top = 0 if new-top > 0
	new-top = ws if new-top < ws

	$nav.css \top new-top + \px

	last-scroll-top := st

$w
	.on \scroll + bind-suffix, scroll-handler
	.on \resize + bind-suffix, resize-handler

scroll-handler!

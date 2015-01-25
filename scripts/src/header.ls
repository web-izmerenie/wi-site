/**
 * Header
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	jquery : $
	'./basics' : b
	'./link-handler'
	'./has-el-by-hash'
}

$w = $ window
$html = $ \html
$page = $ 'html,body'

$body = $html.find \body
$header = $body.find \header
$logo = $header.find '.logo'
$call-menu = $header.find \.call-menu
$menu = $header.find \.menu
$nav = $menu.find \nav
$nav-links = $nav.find \a
$height-helper = $header.find \.height-helper

$cards = $ \.general-cards
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

do !-> # menu vertical scroll
	bind-suffix = \.header-menu-vertical-scroll

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
		.on \scroll + bind-suffix, scroll-handler
		.on \resize + bind-suffix, resize-handler

	scroll-handler!

do !-> # show fixed header block after scroll down
	if not main-page # for other pages use fixed header always
		$header.addClass \scroll-menu-active
		return

	bind-suffix = \.header-menu-show-after-cards

	scroll-handler = !->
		st = $w.scrollTop! + $height-helper.height!
		if st >= $cards.height!
			$header.addClass \scroll-menu-active
		else
			$header.removeClass \scroll-menu-active

	$w
		.on \scroll + bind-suffix, scroll-handler
		.on \resize + bind-suffix, scroll-handler

	scroll-handler!

do !-> # detect current anchor by scroll
	bind-suffix = \.header-menu-auto-detect-current-anchor

	cur-page-hashes = {}

	if main-page # TODO many cards
		cur-page-hashes[\#card-1] =
			$section: $ \#card-1
			$nav-link: null

	pathname = window.location.pathname

	$nav-links.each !->
		if @pathname is pathname and has-el-by-hash @hash
			cur-page-hashes[@hash] =
				$section: $ @hash
				$nav-link: $ @

	scroll-handler = !->
		return if $body.hasClass \scrolling

		st = $w.scrollTop!
		stof = st + $height-helper.height!
		last-hash = null
		last-top = null

		for hash, val of cur-page-hashes
			el-top = val.$section .offset! .top
			if stof >= el-top and (not last-top? or el-top > last-top)
				last-hash = hash
				last-top = el-top

		if last-hash? and last-hash is not window.location.hash
			$nav-links.removeClass \active
			$nav-link = cur-page-hashes[last-hash].$nav-link
			$nav-link.addClass \active if $nav-link?
			window.location.hash = last-hash
			$page.scrollTop st

	$w
		.on \scroll + bind-suffix, scroll-handler
		.on \resize + bind-suffix, scroll-handler

	scroll-handler!

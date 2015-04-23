/**
 * detect current anchor by scroll
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	jquery: $
	\jquery.timers
	\../basics : {get-val}
	\../has-el-by-hash
}

$w = $ window

$html = $ \html
$page = $ 'html, body'
$body = $html.find \body
$header = $body.find \header
$menu = $header.find \.menu
$nav = $menu.find \nav
$nav-links = $nav.find \a
$height-helper = $header.find \.height-helper

main-page = $html.has-class \general-page

bind-suffix = \.header-menu-auto-detect-current-anchor

cur-page-hashes = {}

if main-page # TODO many cards
	cur-page-hashes[\#card-n1] =
		$section: $ \#card-n1
		$nav-link: null

pathname = window.location.pathname

$nav-links.each !->
	if @pathname is pathname and has-el-by-hash @hash
		cur-page-hashes[@hash] =
			$section: $ @hash
			$nav-link: $ @

scroll-handler = !->
	return if $body.has-class \scrolling

	st = $w.scroll-top!
	stof = st + $height-helper.height!
	new-hash = null
	last-top = null

	for hash, val of cur-page-hashes
		el-top = val.$section.offset!.top
		if stof >= el-top and (not last-top? or el-top > last-top)
			new-hash = hash
			last-top = el-top

	if new-hash? and new-hash isnt window.location.hash
		$nav-links.remove-class \active
		$nav-link = cur-page-hashes[new-hash].$nav-link
		$nav.stop-time \header-size-calc
		$nav-link.add-class \active if $nav-link?
		new-hash |> window.history.replace-state null, null, _

		$nav.one-time (\animation-speed |> get-val), \header-size-calc, !->
			$w.trigger \scroll.header-size-calc

$w
	.on "scroll#{bind-suffix}", scroll-handler
	.on "resize#{bind-suffix}", scroll-handler

scroll-handler!

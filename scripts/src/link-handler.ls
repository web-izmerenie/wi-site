/**
 * Link handler module
 * Detect anchor in link and scrolling to anchor (if anchor on current page).
 *
 * @author Viacheslav Lotsmanov
 * @license GNU/AGPLv3
 * @see {@link https://github.com/web-izmerenie/wi-site/blob/master/LICENSE-AGPLv3|License}
 */

require! {
	prelude : _p
	jquery : $
	'./basics' : b
	'./has-el-by-hash'
}

$page = null
$html = null
$body = null
$header = null
$height-helper = null
$nav-links = null

scrolling = false

module.exports = ->
	return false if scrolling
	scrolling := true

	if not $html then
		$page := $ 'html,body'
		$html := $ \html
		$body := $html.find \body
		$header := $body.find \header
		$height-helper := $header.find \.height-helper
		$nav-links := $header .find '.menu nav a'

	$body.addClass \scrolling

	# parse link href
	href = @href
	pathname = @pathname
	hash = @hash

	pathname = window.location.pathname if _p.empty pathname

	# ignore handler and go to link
	return true if pathname is not window.location.pathname

	# DOM element with id equals to hash must be exists (or link is broken)
	if not has-el-by-hash hash
		window.alert b.get-local-text \err,
			\detect-link-anchor, \#LINK_HREF# : href
		scrolling := false
		$body.removeClass \scrolling
		return false

	# reset to hash plug
	window.location.hash = '#/'

	$nav-links.each !->
		@pathname = window.location.pathname if _p.empty @pathname
		return if @pathname is not pathname
		if @pathname + @hash is pathname + hash
			$ @ .addClass \active
		else
			$ @ .removeClass \active

	top = ($ hash .offset! .top) - $height-helper.height!

	# start scrolling
	$page .stop! .animate { \scroll-top : top },
		((b.get-val \animation-speed) * 4), !->
			window.location.hash = hash
			$page.scrollTop top # restore header offset, because we set window.location.hash and it scrolls to block
			scrolling := false
			$body.removeClass \scrolling

	false

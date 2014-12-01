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
$header = null

scrolling = false

module.exports = ->
	return false if scrolling
	scrolling := true

	if not $page then
		$page := $ 'html,body'
		$header := $ \header

	# parse link href
	href = $ this .attr \href
	pathname = href |> _p.take-while (is not \#)
	hash = href |> _p.drop-while (is not \#)

	pathname = window.location.pathname if _p.empty pathname

	# ignore handler and go to link
	return true if pathname is not window.location.pathname

	# DOM element with id equals to hash must be exists (or link is broken)
	if not has-el-by-hash hash
		window.alert b.get-local-text \err,
			\detect-link-anchor, \#LINK_HREF# : href
		scrolling := false
		return false

	# reset to hash plug
	window.location.hash = '#/'

	top = ($ hash .offset! .top) - $header.height!

	# start scrolling
	$page .stop! .animate { \scroll-top : top },
		((b.get-val \animation-speed) * 4), !->
			window.location.hash = hash
			$page.scrollTop top # restore header offset, because we set window.location.hash and it scrolls to block
			scrolling := false

	false

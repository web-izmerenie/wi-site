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

	href = $ this .attr \href
	pathname = href |> _p.take-while (is not \#)
	hash = href |> _p.drop-while (is not \#)

	if _p.empty pathname
		pathname = window.location.pathname

	if pathname is not window.location.pathname
		window.location = href
		scrolling := false
		return false

	if not has-el-by-hash hash
		window.alert b.get-local-text \err,
			\detect-link-anchor, \#LINK_HREF# : href
		scrolling := false
		return false

	window.location.hash = '#/'
	top = $ hash .offset! .top

	# TODO fix
	top -= $header.height!

	$page .stop! .animate { \scroll-top : top },
		((b.get-val \animation-speed) * 4), !->
			window.location.hash = hash
			$page.scrollTop top
			scrolling := false

	false

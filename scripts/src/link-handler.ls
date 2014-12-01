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
}

$page = $ 'html,body'
$header = $ \header

speed = b.get-val \animation-speed
scrolling = false

module.exports = ->
	return false if scrolling
	scrolling := true

	href = $ this .attr \href
	pathname = _p.take-while (is not \#), href
	hash = _p.drop-while (is not \#), href

	if _p.empty pathname
		pathname = window.location.pathname

	if pathname is not window.location.pathname
		console.log 111
		window.location = href
		scrolling := false
		return false

	if hash.length < 2 or $ hash .length <= 0
		window.alert b.get-local-text \err,
			\detect-link-anchor, \#LINK_HREF# : href
		scrolling := false
		return false

	window.location.hash = '#/'
	top = $ hash .offset! .top

	# TODO fix
	top -= $header.height!

	$page .stop! .animate { \scroll-top : top },
		(speed*4), !->
			window.location.hash = hash
			$page.scrollTop top
			scrolling := false

	false

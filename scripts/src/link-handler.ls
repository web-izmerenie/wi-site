/**
 * Link handler module
 * Detect anchor in link and scrolling to anchor (if anchor on current page).
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	prelude: {empty}
	jquery: $
	\./basics : {get-local-text, get-val}
	\./has-el-by-hash
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

	unless $html
		$page := $ 'html, body'
		$html := $ \html
		$body := $html.find \body
		$header := $body.find \header
		$height-helper := $header.find \.height-helper
		$nav-links := $header .find '.menu nav a'

	$body.add-class \scrolling

	# parse link href
	href = @href
	pathname = @pathname
	hash = @hash

	pathname = window.location.pathname if empty pathname

	# ignore handler and go to link
	return true if pathname is not window.location.pathname

	# DOM element with id equals to hash must be exists (or link is broken)
	unless has-el-by-hash hash
		window.alert get-local-text \err,
			\detect-link-anchor, \#LINK_HREF# : href
		scrolling := false
		$body.remove-class \scrolling
		return false

	# reset to hash plug
	window.location.hash = \#/

	$nav-links.each !->
		@pathname = window.location.pathname if empty @pathname
		return if @pathname is not pathname
		if @pathname + @hash is pathname + hash
			$ @ .add-class \active
		else
			$ @ .remove-class \active

	top = $ hash .offset!.top |> (- $height-helper.height!)

	# start scrolling
	$page.stop!.animate \scroll-top : top,
		get-val \animation-speed |> (* 4), !->
			window.location.hash = hash
			$page.scroll-top top # restore header offset, because we set window.location.hash and it scrolls to block
			scrolling := false
			$body.removeClass \scrolling

	false

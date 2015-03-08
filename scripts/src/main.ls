/**
 * Main module
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	prelude: {drop-while}
	jquery: $
	modernizr: Modernizr
	\./basics : {init}
	\./has-el-by-hash
}

hash = window.location.hash |> drop-while (isnt \#)

# if we have hash, we need to reset it to plug and scroll handly later (smooth scroll)
if hash.length > 1
	window.location.hash = \#/
	<!- $
	if has-el-by-hash hash
		$ 'html, body' .scroll-top 0
	else
		window.location.hash = hash

<-! init # when dom and styles are ready

$html = $ \html

$header = $html.find \header
$helper = $ \<div>, class: \height-helper
$header.append $helper

# scroll to anchor if exists by hash
if has-el-by-hash hash
	require! \./link-handler

	$ 'html, body' .scroll-top 0

	go-to-anchor = !->
		# fake link for use link-handler
		$link = $ \<a/>, href: window.location.pathname + hash
		$link
			.click link-handler
			.trigger \click

	if $html.has-class \general-page
		$html.data \go-to-anchor, go-to-anchor
	else
		go-to-anchor!

require \./header/header

require \./pages/general if $html.has-class \general-page

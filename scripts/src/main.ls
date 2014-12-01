/**
 * Main module
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

hash = window.location.hash |> _p.drop-while (is not \#)

# if we have hash, we need to reset it to plug and scroll handly later (smooth scroll)
if hash.length > 1
	window.location.hash = '#/'
	$ !->
		if has-el-by-hash hash
			$ 'html,body' .scrollTop 0
		else
			window.location.hash = hash

b.init !-> # when dom and styles are ready
	$html = $ \html

	$header = $html.find \header
	$helper = $ '<div>', class: \height-helper
	$header.append $helper

	# scroll to anchor if exists by hash
	if has-el-by-hash hash
		require! './link-handler'

		$ 'html,body' .scrollTop 0

		go-to-anchor = !->
			# fake link for use link-handler
			$link = $ '<a/>', href: window.location.pathname + hash
			$link
				.click link-handler
				.trigger \click

		if $html.hasClass \general-page
			$html.data \go-to-anchor, go-to-anchor
		else
			go-to-anchor!

	require './header'

	if $html.hasClass \general-page then require './pages/general'

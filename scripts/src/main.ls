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

if hash.length > 1
	window.location.hash = '#/'
	$ !->
		if has-el-by-hash hash
			$ 'html,body' .scrollTop 0
		else
			window.location.hash = hash

b.init !-> # when dom and styles is ready
	$html = $ \html

	if has-el-by-hash hash
		$ 'html,body' .scrollTop 0
		require! './link-handler'
		$link = $ '<a/>', href: window.location.pathname + hash
		$link
			.click link-handler
			.trigger \click

	require './header'

	if $html.hasClass \general-page then require './pages/general'

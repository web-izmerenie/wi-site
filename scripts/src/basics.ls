/**
 * Basic modules wrapper
 *
 * @author Viacheslav Lotsmanov
 * @license GNU/AGPLv3
 * @see {@link https://github.com/web-izmerenie/wi-site/blob/master/LICENSE-AGPLv3|License}
 */

require! jquery : $

module.exports =
	get-val: null
	get-local-text: null
	load-img: null
	init: null

b = module.exports

module.exports.init = (cb) !-> $ !->
	$html = $ \html
	required = lang: $html.attr \lang

	require! {
		'./lib/get_val' : GetVal
		'./lib/get_local_text' : GetLocalText
		'./lib/load_img' : LoadImg
		'./values'
		'./localization'
	}

	b.get-val = new GetVal values , required
	b.get-local-text =
		new GetLocalText localization, b.get-val \lang, true
	b.load-img = new LoadImg b.get-val \load-img-timeout, true

	$head = $html.find \head
	$cur-link = $head.find \link.main-styles
	if $cur-link.length <= 0 or not $cur-link.attr \href
		window.alert b.get-local-text \err, \styles, \path-detect

	timer-id = null

	href = $cur-link.attr \href
	$new-link = $ '<link/>', { type: 'text/css', rel: \stylesheet }
	$new-link.load !->
		clearTimeout timer-id
		b.get-val.set \styles-href href
		set-timeout cb, 0

	timeout = (b.get-val \styles-load-timeout, true) * 1000
	fail-cb = !->
		window.alert b.get-local-text \err, \styles, \load-timeout
	timer-id = set-timeout fail-cb, timeout

	$new-link.attr \href, href
	$head.append $new-link

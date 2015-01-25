/**
 * Basic modules wrapper
 *
 * @author Viacheslav Lotsmanov
 */

require! jquery : $

module.exports =
	get-val: null
	get-local-text: null
	load-img: null
	init: null

# short alias
b = module.exports

# callback will be called when dom and styles are ready both
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

	# create basics modules instances
	b.get-val = new GetVal values , required
	b.get-local-text =
		new GetLocalText localization, b.get-val \lang, true
	b.load-img = new LoadImg b.get-val \load-img-timeout, true

	# check for exists <link> with "main-styles" class
	$head = $html.find \head
	$cur-link = $head.find \link.main-styles
	if $cur-link.length <= 0 or not $cur-link.attr \href
		window.alert b.get-local-text \err, \styles, \path-detect

	timer-id = null

	# load styles file
	href = $cur-link.attr \href
	$new-link = $ '<link/>', { type: 'text/css', rel: \stylesheet }
	$new-link.load !->
		clear-timeout timer-id
		b.get-val.set \styles-href href
		set-timeout cb, 0

	# show error when loading timeout
	timeout = (b.get-val \styles-load-timeout, true) * 1000
	fail-cb = !->
		window.alert b.get-local-text \err, \styles, \load-timeout
	timer-id = set-timeout fail-cb, timeout

	$new-link.attr \href, href
	$head.append $new-link # start loading

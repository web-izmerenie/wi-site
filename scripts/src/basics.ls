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
	init: null

module.exports.init = (cb) !-> $ !->
	$html = $ \html
	required = lang: $html.attr \lang

	require! {
		'./lib/get_val' : GetVal
		'./values'
	}

	module.exports.get-val = new GetVal values , required

	cb!

/**
 * Main module
 *
 * @author Viacheslav Lotsmanov
 * @license GNU/AGPLv3
 * @see {@link https://github.com/web-izmerenie/wi-site/blob/master/LICENSE-AGPLv3|License}
 */

require! {
	jquery : $
	'./basics' : b
}

b.init !-> # when dom and styles is ready
	$html = $ \html
	if $html.hasClass \general-page then require './pages/general'

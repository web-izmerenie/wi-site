/**
 * blog page route handler
 *
 * @author Viacheslav Lotsmanov
 * @license GNU/AGPLv3
 * @see {@link https://www.gnu.org/licenses/agpl-3.0.txt|License}
 */

require! {
	\../config : {config}
	\../helpers/basic-tpl-data : {get-typical-page-data}
	\../helpers/render-promise : {render-promise}
	co
}

export get = (app, req, res)-> co ->*
	cfg = yield config
	data =
		do
			html-classes: <[blog-page sub-page]>
			body-classes: <[loaded]>
		<<< (yield get-typical-page-data app, req)
	yield render-promise res, "pages/#{cfg.LANG}/blog", {data}

export head = !-> get ... # delegate HEAD to GET


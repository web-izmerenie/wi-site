/**
 * feedback form post route handler
 *
 * @author Viacheslav Lotsmanov
 * @license GNU/AGPLv3
 * @see {@link https://www.gnu.org/licenses/agpl-3.0.txt|License}
 */

require! {
	\../config : {config}
	\../helpers/basic-tpl-data : {get-typical-page-data}
	\../helpers/render-promise : {render-promise}
	\../helpers/mailer-promise : {send-mail}
	co
	path
	jade
}

export get = (app, req, res)-> co ->*
	cfg = yield config

	localization = require path.resolve \
		process.cwd!, cfg.STATIC_PATH, \localization.json
	local = localization[cfg.LANG]

	{TO} = cfg.FORMS.FEEDBACK

	try
		yield send-mail do
			to: TO
			subject: local.forms.feedback.subject
			html: '<b>yeah!</b>'
	catch
		return res.json status: \error

	res.json status: \success

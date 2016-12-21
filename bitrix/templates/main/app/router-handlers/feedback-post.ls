/**
 * feedback form post route handler
 *
 * @author Viacheslav Lotsmanov
 * @license GNU/AGPLv3
 * @see {@link https://www.gnu.org/licenses/agpl-3.0.txt|License}
 */

require! {
	\../config : {config}
	\../utils : {logger, prepare-request-to-log}
	\../helpers/basic-tpl-data : {get-typical-page-data}
	\../helpers/render-promise : {render-promise}
	\../helpers/mailer-promise : {send-mail}
	co
	path
	jade
	\prelude-ls : {all, reject, Str, map, pairs-to-obj, each, obj-to-pairs}
	util: {inspect}
}

fields = <[name phonemail message]>

replace-map =
	# escape html
	* /&/g         , '&amp;'
	* /</g         , '&lt;'
	* />/g         , '&gt;'
	* /"/g         , '&quot;'
	* /'/g         , '&#039;'

	# paragraphs
	* /\r\n/g      , '\n'
	* /^\s+|\s+$/g , ''
	* /[\n]+/g     , '</p><p>'

export post = (app, req, res)-> co ->*
	cfg = yield config

	localization = require path.resolve \
		process.cwd!, cfg.STATIC_PATH, \localization.json
	local = localization[cfg.LANG]

	{TO} = cfg.FORMS.FEEDBACK

	f = -> req.body.has-own-property it and not Str.empty req.body[it]

	unless fields |> all f
		return res.status 400 .json do
			status: \error
			error-code: \required-fields
			fields: fields |> reject f

	# stupid bot detected
	if req.body.has-own-property \q and not Str.empty req.body.q
		logger.warn 'feedback-post.ls:post()',\
			"Detected bot in feedback form post data (filled hidden input).
			\ Request:\n#{inspect (prepare-request-to-log 4, req), depth: 4}"
		return res.status 404 .json do
			status: \error
			error-code: \go-fuck-yourself-stupid-robot

	if req.body.phonemail isnt /^.+@.+$/ and req.body.phonemail isnt /[0-9]/
		return res.status 406 .json do
			status: \error
			error-code: \incorrect-fields
			fields: <[phonemail]>

	form-data = (fields |> map (-> [it, req.body[it]]) |> pairs-to-obj)
	form-data.message |>= (val)->
		replace-map |> each (-> val .:= replace it.0, it.1)
		"<p>#{val}</p>"

	tpl-path = path.resolve cfg.TEMPLATES_PATH, \pages, cfg.LANG, 'feedback-post.jade'
	try
		html = jade.render-file tpl-path, {form-data}
	catch
		logger.error 'feedback-post.ls:post()',\
			"Template render error by file: '#{tpl-path}'", e
		return res.status 500 .json do
			status: \error
			error-code: \template-render-error

	logger.debug 'feedback-post.ls:post()',\
		"Sending mail by form to '#{TO}' by data:\n#{inspect form-data}\n..."
	try
		yield send-mail do
			to: TO
			subject: local.forms.feedback.subject
			html: html
	catch
		return res.json status: \error

	res.json status: \success

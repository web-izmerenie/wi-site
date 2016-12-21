/**
 * nodemailer promise helper
 *
 * @author Viacheslav Lotsmanov
 * @license GNU/AGPLv3
 * @see {@link https://www.gnu.org/licenses/agpl-3.0.txt|License}
 */

require! {
	co
	nodemailer
	util: {inspect}
	\../config : {config}
	\../utils : {logger}
}

instance = null

export init = -> co ->*
	return if instance?
	cfg = yield config
	{SERVICE, USER, PASS} = cfg.EMAIL

	logger.debug 'mailer-promise.ls:init()',\
		"Creating nodemailer transport..."

	instance := nodemailer.create-transport do
		service: SERVICE
		auth:
			user: USER
			pass: PASS

export send-mail = ({
	from
	to
	subject
	text
	html
})-> co ->*
	yield init!

	opts = {from, to, subject, text, html}

	logger.debug 'mailer-promise.ls:send-mail()',\
		"Sending mail by params:\n#{inspect opts, depth: 1}..."

	return yield new Promise (resolve, reject)!->
		instance.send-mail opts, (err, info)!->
			if err?
				logger.error 'mailer-promise.ls:send-mail()',\
					"Send mail error by params:\n#{inspect opts, depth: 1}", err
				return reject err

			logger.debug 'mailer-promise.ls:send-mail()',\
				"Mail sent by params:\n#{inspect opts, depth: 1}..."
			resolve info

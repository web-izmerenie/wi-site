/**
 * express render template promise
 *
 * @author Viacheslav Lotsmanov
 * @license GNU/AGPLv3
 * @see {@link https://www.gnu.org/licenses/agpl-3.0.txt|License}
 */

export render-promise = (res, template, {data={}})->
	new Promise (resolve, reject)!->
		res.render template, data, (err, html)!->
			return reject err if err?
			res
				.set 'Content-Type': 'text/html; charset=utf-8'
				.end html
			resolve!

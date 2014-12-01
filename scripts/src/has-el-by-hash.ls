/**
 * Has DOM-element by hash
 * Checking if element exists with id by specific hash (safe for correct jQuery selector).
 *
 * @author Viacheslav Lotsmanov
 * @license GNU/AGPLv3
 * @see {@link https://github.com/web-izmerenie/wi-site/blob/master/LICENSE-AGPLv3|License}
 */

require! {
	prelude : _p
	jquery : $
}

module.exports = (url) ->
	hash = url |> _p.drop-while (is not \#)
	hash-id = hash |> _p.drop 1
	correct-hash = /^[a-zA-Z0-9-_]+$/.test hash-id

	# safe jQuery selector
	return false if not correct-hash

	$ hash .length > 0
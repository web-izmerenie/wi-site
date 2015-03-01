/**
 * Has DOM-element by hash
 * Checking if element exists with id by specific hash (safe for correct jQuery selector).
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	prelude: {drop-while, drop}
	jquery: $
}

module.exports = (url) ->
	hash = url |> drop-while (isnt \#)
	hash-id = hash |> drop 1
	correct-hash = hash-id is /^[a-zA-Z0-9-_]+$/

	# safe jQuery selector
	return false unless correct-hash

	$ hash .length > 0

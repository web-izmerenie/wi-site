/**
 * utils module
 *
 * @author Viacheslav Lotsmanov
 * @license GNU/AGPLv3
 * @see {@link https://www.gnu.org/licenses/agpl-3.0.txt|License}
 */

require! {
	winston: {Logger, transports: logger-transports}
	\prelude-ls : {Str, map, pairs-to-obj, obj-to-pairs, filter}
}

export logger = new Logger do
	transports:
		new logger-transports.Console do
			colorize: \all
			timestamp: on
		...

# filter helper for "prepare-request-to-log"
export reject-unloggable-request-keys =
	(filter (-> (it.0 |> Str.take 1) isnt \_)) >>\
	(filter (-> typeof! it.1 in <[Number String Object Array Float Boolean]>))

# prepare request object to log
export prepare-request-to-log = (max-depth, req, cur-depth=1)->
	req-data =
		req
		|> obj-to-pairs
		|> reject-unloggable-request-keys
		|> map ->
			| cur-depth <= max-depth and typeof! it.1 is \Object =>
				[it.0, (prepare-request-to-log max-depth, it.1, cur-depth + 1)]
			| otherwise => [it.0, it.1]
		|> pairs-to-obj

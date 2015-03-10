/**
 * size calculators helpers
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	jquery: $
	prelude: {
		map, each, camelize, lists-to-obj, Obj, obj-to-pairs, pairs-to-obj, at
	}
	\./lib/relative_number.js : relnum
	\./get-rel-screen-size
	\./basics : {get-val}
}

widths = \responsive-widths |> get-val

get-rel = --> it |> Obj.keys |> at 0 |> (-> widths[it])

get-relval = (vals, min, max) -->
	{screen-w} = get-rel-screen-size!

	relnum do
		rel-val: screen-w
		rel-min: vals.0 |> get-rel
		rel-max: vals.1 |> get-rel
		min: min
		max: max

get-el-vals = (el-key, val) -->
	val |> Obj.values |> at 0 |> (--> it[el-key |> camelize])

get-rel-vals = (vals, el-key, keys) -->
	get-el-vals-c = get-el-vals el-key

	from = vals.0 |> get-el-vals-c
	to = vals.1 |> get-el-vals-c

	keys
		|> map camelize
		|> map (-> get-relval vals, from[it], to[it])
		|> lists-to-obj (keys |> map camelize)
		|> obj-to-pairs
		|> map (-> it.1 = Math.round it.1 unless it.0 is \scale; it)
		|> pairs-to-obj

# to DOM or jQuery element(s)
set-typical-sizes = (vals, el-key, $el) !-->
	vals.0
		|> Obj.values
		|> at 0
		|> (-> it[el-key |> camelize])
		|> Obj.keys
		|> get-rel-vals vals, el-key
		|> Obj.map (+ \px)
		|> $el.css

# to array of DOM or jQuery objects
set-typical-sizes-to-array = (vals, el-key, arr) !-->
	css = vals.0
		|> Obj.values
		|> at 0
		|> (-> it[el-key |> camelize])
		|> Obj.keys
		|> get-rel-vals vals, el-key
		|> Obj.map (+ \px)
	arr |> each (-> $ it .css css)

module.exports = {
	get-relval
	get-rel-vals
	set-typical-sizes
	set-typical-sizes-to-array
}

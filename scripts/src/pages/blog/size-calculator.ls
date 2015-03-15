/**
 * size calculator for blog page elements
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	prelude: {
		map, each, lists-to-obj, obj-to-pairs, pairs-to-obj, Str, Obj, camelize
	}
	jquery: $
	\../../basics : {get-val}
	\../../get-rel-screen-size
	\../../size-calc-helpers
}

$w = $ window
$body = $ \body

$s = $ \.blog
$top-line = $s.find \.top-line
$search-form = $top-line.find \form.search-form
$content-zone = $s.find \.content-zone
$cols = $content-zone.find \>.col
$col-left = $content-zone.find \>.col-left
$col-right = $content-zone.find \>.col-right
$col-right-tags = $col-right.find \.tags
$col-right-tags-header = $col-right-tags.find \h3
$posts = $col-left.find \ul.posts
$posts-items = $posts.find \>li
$posts-items-first = $posts.find \>li:first
$posts-items-first-title = $posts-items-first.find \h3
$posts-items-without-first = $posts.find \>li |> (-> Array::shift.call it; it)
$posts-items-without-first-title = $posts-items-without-first.find \h3
$posts-text-font = $posts-items.find 'time, .text'

bind-suffix = \.blog-page-sizes-calc

widths = \responsive-widths |> get-val
vals-src = \blog-page |> get-val
list-sizes = \blog-list-sizes |> get-val

vals = [<[small middle]> <[middle big]>]
	|> map -> [(it |> map Str.take 1 |> Str.unchars), it]
	|> pairs-to-obj
	|> Obj.map map (-> [vals-src[it]] |> lists-to-obj [it])

calc = <[get-rel-vals set-typical-sizes]>
	|> map camelize
	|> map (-> [it, size-calc-helpers[it]])
	|> pairs-to-obj
	|> Obj.map (-> vals |> Obj.map it)

list-space-calc = (w, it) !-->
	it
	|> (* w)
	|> (/ 100)
	|> (-> $posts-items.css margin-left: "#{it}px"; it)
	|> !->
		$posts.css do
			margin-left: "-#{it}px"
			width: "#{w + it}px"

<-! (!-> $w.on "resize#bind-suffix" it .trigger "resize#bind-suffix")
{screen-w, screen-w-abs} = get-rel-screen-size!

range-key = do ->
	| screen-w >= widths.middle => \mb
	| _ => \sm

do # small-middle
	\blog : $s
|> obj-to-pairs
|> each (!-> calc.set-typical-sizes.sm it.0, it.1)

# middle-big
let f = (!-> calc.set-typical-sizes.mb it.0, it.1)
	do
		\top-line : $top-line
		\col-right : $search-form
		\col-right-tags-header : $col-right-tags-header
		\post-item : $posts-items
		\post-special-title-font : $posts-items-first-title
		\post-title-font : $posts-items-without-first-title
		\post-text-font : $posts-text-font
	|> obj-to-pairs
	|> each f

	do # cols
		\col-left : $col-left
		\col-right : $col-right
	|> obj-to-pairs
	|> each f

/*
do # small-middle and middle-big
	\copyright-text-block : $text
|> obj-to-pairs
|> each (!-> calc.set-typical-sizes[range-key] it.0, it.1)
*/

$col-left.css width: $content-zone.width! - $col-right.width!

do !->
	# reset
	$posts.css do
		margin-left: ''
		width: ''
	$posts-items.css do
		margin-left: ''
		width: ''

	w = $col-left.width!

	switch
	| screen-w-abs >= 1400px =>
		$posts-items-first.css width: "#{list-sizes.post-special-width * w / 100}px"
		$posts-items-without-first.css width: "#{list-sizes.post-item-width * w / 100}px"
		list-sizes.post-space-percent |> list-space-calc w
	| _ =>
		$posts-items-first.css width: "#{w}px"
		$posts-items-without-first.css width: "#{list-sizes.post-item-width-s * w / 100}px"
		list-sizes.post-space-percent-s |> list-space-calc w

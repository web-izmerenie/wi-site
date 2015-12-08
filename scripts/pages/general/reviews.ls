/**
 * General page "reviews" section behavior
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	jquery: $
	\jquery-kinetic : {}
	\smooth-div : {}
	modernizr: {}
}

$s = $ \.reviews
$list = $s.find \ul.reviews-list
$list-elems = $list.find \>li
$list-links = $list-elems.find \a

do -> # list scroll centering
	width = 0
	margin-x = 0
	space = 0

	if $list-elems.length > 0
		width = $list-elems.first!.width!
		margin-x = $list-elems.first!.css \margin-left |> parse-int _, 10
		if $list-elems.length > 1
			space = $list-elems.last!.css \margin-left |> parse-int _, 10

	sum = width * $list-elems.length
		|> (+ (margin-x * 2))
		|> (+ (space * ($list-elems.length - 1)))

	if sum > $list.width! # has scroll
		sum
		|> (- $list.width!)
		|> (/ 2)
		|> $list.scroll-left _

$list-links
	.on \focus !->
		$list-elems.remove-class \focused
		$ @ .closest \li .add-class \focused
	.on \blur !-> $ @ .closest \li .remove-class \focused

$list.smooth-div-scroll do
	if Modernizr.touch
		touchScrolling: true
		hotSpotScrolling: false
	else
		touchScrolling: false
		hotSpotScrolling: true

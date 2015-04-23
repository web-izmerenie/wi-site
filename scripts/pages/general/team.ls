/**
 * General page "team" section behavior
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	jquery: $
}

$s = $ \.team
$people-list = $s.find \ul.people
$people-list-elems = $people-list.find \>li
$people-links = $people-list-elems.find \>a

do -> # people scroll centering
	$list = $people-list
	$elems = $people-list.find \>li
	return unless $elems.length > 0

	sum = 0
		|> (+ ($elems.first!.css \margin-left |> parse-int _, 10))
		|> (+ $elems.first!.width!)
		|> (+ ($elems.last!.css \margin-right |> parse-int _, 10))
	if $elems.length > 1
		sum += $elems.last!.width!
			|> (+ ($elems.last!.css \margin-left |> parse-int _, 10))

	# drop first and last
	Array.prototype.shift.call $elems
	Array.prototype.pop.call $elems

	$elems.each !-> sum +=
		$ @ .css \margin-left
		|> parse-int _, 10
		|> (~> it + ($ @ .width!))

	if sum > $list.width! # has scroll
		sum
		|> (- $list.width!)
		|> (/ 2)
		|> $list.scroll-left _

$s
	.find \ul.people>li>a
	.on \click, -> false

<-! $people-links.each
$link = $ @
<-! $ @ .find \img .each
$img = $ @

$to-load = $ \<img/>
	.on \load, !->
		$link.css height: $img.height!
		$img
			.css bottom: -5px
			.add-class \loaded
	.attr \src, $img.attr \src

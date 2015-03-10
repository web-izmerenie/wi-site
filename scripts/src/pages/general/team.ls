/**
 * General page "team" section behavior
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	jquery: $
}

$s = $ \.team
$people-links = $s.find \ul.people>li>a

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

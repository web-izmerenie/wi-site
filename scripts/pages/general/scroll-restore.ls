/**
 * Scroll restore helper after window resize
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	prelude: {map, find}
	jquery: $
}

$w = $ window
$d = $ document
$header = $ \header
$height-helper = $header.find \.height-helper

sections = <[card-n1 portfolio team]>
	|> map (-> "\##it")
	|> map (-> $ it)

bind-suffix = \.general-page-scroll-restore

$last-elem = null
last-elem-pos = 0 # percents

module.exports.bind-before = !->
	<-! $w.on "resize#bind-suffix"

	st = $w.scroll-top! + $height-helper.height!
	$last-elem := sections
		|> find (-> st >= it.offset!.top and st < it.offset!.top + it.height!)

	return last-elem-pos := 0 unless $last-elem?

	last-elem-pos :=
		st
		|> (- $last-elem.offset!.top)
		|> (* 100)
		|> (/ $last-elem.height!)

module.exports.bind-after = !->
	<-! $w.on "resize#bind-suffix"
	return unless $last-elem?

	$last-elem.offset!.top
		|> (- $height-helper.height!)
		|> (+ (last-elem-pos |> (* $last-elem.height!) |> (/ 100)))
		|> $d.scroll-top _

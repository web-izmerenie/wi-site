/**
 * icons generator for blog page
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	jquery: $
	prelude: {each}
	\Snap.svg
}

$s = $ \.blog
$top-line = $s.find \.top-line
$rss-link = $top-line.find \.rss-link

do -> # rss-link
	icon-path = $rss-link.attr \data-icon
	return unless !!icon-path

	$i = $ \<i/> class: \icon
	$i.append-to $rss-link
	color = $i.css \color
	return unless color

	(f) <-! Snap.load icon-path

	icon = f.select \#icon .add-class \icon .attr id: ''
	Snap!
		|> (.append f)
		|> (.append-to $i.0)
		|> (.select \.icon)
		|> (-> [it, it.select-all \*])
		|> each (!-> it.attr fill: color if it?)

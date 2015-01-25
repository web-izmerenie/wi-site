/**
 * General page "portfolio" section behavior
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	jquery : $
}

$w = $ window
$s = $ \.portfolio
$header = $ \header
$height-helper = $header.find \.height-helper
$elems = $s.find 'ul>li'
$more-block = $s.find \.more-block
$more = $more-block.find '>a'

$more.click -> false

do !-> # show element by scroll
	bind-suffix = \.general-page-portfolio-show-elements-by-scroll

	scroll-handler = !->
		scroll-val = $w.scrollTop! + $w.height!

		for item in $elems
			$item = $ item
			if scroll-val > $item .offset! .top
				$item.addClass \visible
			else
				$item.removeClass \visible

	$w
		.on \scroll + bind-suffix, scroll-handler
		.on \resize + bind-suffix, scroll-handler

	scroll-handler!

/**
 * General page "portfolio" section behavior
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	jquery: $
}

$w = $ window
$s = $ \.portfolio
$header = $ \header
$height-helper = $header.find \.height-helper
$elems = $s.find \ul>li
$more-block = $s.find \.more-block
$more = $more-block.find \>a

do !-> # show element by scroll
	bind-suffix = \.general-page-portfolio-show-elements-by-scroll

	scroll-handler = !->
		scroll-val = $w.scroll-top! + $w.height!

		for item in $elems
			$item = $ item
			if scroll-val > $item.offset!.top
				$item.add-class \visible
			else
				$item.remove-class \visible

	$w
		.on "scroll#bind-suffix", scroll-handler
		.on "resize#bind-suffix", scroll-handler

	scroll-handler!

$more.click ->
	$.ajax do
		url: '/ajax/portfolio_page.php'
		dataType: \json
		method: \GET
		cache: false
		async: true
		data: {page: parseInt($('#portfolio .more-block a').attr('data-page'))}
	.success (json, text-status, jq-XHR)!->
		for item in json.ITEMS
			element = $('#portfolio ul li:first').clone()
			element.find('h3').text(item.NAME)
			element.find('img').attr('src', item.PREVIEW_PICTURE.SRC)
			element.find('img').attr('alt', item.PREVIEW_PICTURE.ALT)
			element.appendTo($('#portfolio ul'));
		$elems := $s.find \ul>li
		if json.NEXT_PAGE
			page = parseInt($('#portfolio .more-block a').attr('data-page')) + 1
			$('#portfolio .more-block a').attr('data-page', page)
		else
			$('#portfolio .more-block a').remove()
	.error (jq-XHR, text-status, error-thrown)!->
		false
	.done !->
		false
	false
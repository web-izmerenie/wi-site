/**
 * General page "contacts" section behavior
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	jquery: $
	prelude: {Obj, is-type, Num, Str}
	\../../basics : {dynamic-api, get-val, get-local-text}
}

get-api-url = module.exports.get-yandex-maps-api-url = ->
	api-lang = get-val \yandex-maps-api-lang |> (."#{get-val \lang}")
	"http://api-maps.yandex.ru/2.1/?lang=#api-lang"

<-! (!-> module.exports.init = it)

(i) <-! $ \.contacts .each

$s = $ @
$head = $s.find \.head
$map = $head.find \.map
$marker = $map.find \img.marker
$address = $s.find \address
$second = $s.find \.second
$form = $second.find \form
$inputs-labels = $form.find 'label.text, label.textarea'
$inputs = $inputs-labels.find 'input, textarea'

!->
	if !!($ @ .val!)
		$ @ .add-class \has-value
	else
		$ @ .remove-class \has-value
|> (-> $inputs.on \change, it .on \focus, it .on \blur, it .trigger \change)

is-response-valid = ->
	unless $.is-plain-object it
		err = new Error "Incorrect JSON response: '#{it}'"
		window.alert err.message
		console.error err
		return false
	true

$form.on \reset, !->
	$inputs-labels.trigger \remove-error-message
	$inputs.val '' .trigger \blur

$form.on \submit, ->
	return false if $form.has-class \process

	$form.add-class \process
	$inputs-labels.trigger \remove-error-message

	$.ajax do
		url: '/feedback-post.json'
		data-type: \json
		method: \POST
		cache: false
		async: true
		data: $form.serialize!
	.success (json, text-status, jq-XHR)!->
		return unless is-response-valid json

		if json.status is \success
			window.alert get-local-text \forms, \feedback-success-msgbox
			$form.trigger \reset
		else
			window.alert get-local-text \err, \ajax, \unknown-error
	.error (jq-XHR, text-status, error-thrown)!->
		json = jq-XHR.response-JSON
		return unless is-response-valid json

		if json.status is \error and \
		json.error-code in <[required-fields incorrect-fields]> and \
		json.fields?
			(field) <-! json.fields.for-each
			$input = $form.find "input[name='#{field}'], textarea[name='#{field}']"
			$label = $input.closest \label
			$label.add-class \error
			$label
				.data \error-message-jq-el, ($ '<div/>', class: \error-message)
				.data \error-message-jq-el
				.html (get-local-text \err, \ajax, (json.error-code.slice 0, -1))
			$label
				.append $label.data \error-message-jq-el
				.on \remove-error-message, !->
					$input.off \focus.error-message-hide
					$label
						.off \remove-error-message
						.remove-class \error
					$label
						.data \error-message-jq-el
						.animate {opacity: 0}, (get-val \animation-speed), !->
							$ @ .remove!
							$input = void
							$label = void
			$input.on \focus.error-message-hide ->
				$label.trigger \remove-error-message
		else
			window.alert get-local-text \err, \ajax, \unknown-error
	.complete !->
		$form.remove-class \process

	false

(err, ymaps) <-! dynamic-api get-api-url!, \ymaps
return if err?
<-! ymaps.ready

data =
	mark-x: $map.attr \data-mark-x |> parse-float
	mark-y: $map.attr \data-mark-y |> parse-float
	pos-x: $map.attr \data-pos-x |> parse-float
	pos-y: $map.attr \data-pos-y |> parse-float
	zoom: $map.attr \data-zoom |> parse-int _, 10

try
	data |> Obj.map ->
		if (it |> is-type \Number |> (not)) or (it |> Num.is-it-NaN)
			throw new Error!
catch
	return window.alert get-local-text \err, \yandex-map-not-enough-data

map-id = "yandex_map_#i"
$map.attr \id, map-id

marker-path = $marker.attr \src
$img = $ \<img/>
<-! (!-> $img.on \load, it; $img.attr \src, marker-path)
img = @

map = new ymaps.Map map-id, do
	center: [data.pos-y, data.pos-x]
	zoom: data.zoom
	controls: []

map.behaviors.disable \scrollZoom

map.controls.add \zoomControl, do
	float: 'none'
	position: left: 10, top: 10

marker = new ymaps.Placemark [data.mark-y, data.mark-x], do
	hint-content: $address.text!
	icon-content: \sheeeit
, do
	icon-layout: \default#image
	icon-image-href: marker-path
	icon-image-size: [img.width, img.height]
	icon-image-offset: [-(img.width/2), -img.height]

map.geo-objects.add marker

<-! (!-> $map.on \resize-map it .trigger \resize-map)
map.container.fit-to-viewport!

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

<-! (!-> module.exports.init = it)

(i) <-! $ \.contacts .each

$s = $ @
$head = $s.find \.head
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


require! \gmaps
$map = $s.find \.map
$marker = $map.find \img.marker
$pos-y = $map.data \pos-y
$pos-x = $map.data \pos-x
$mark-y = $map.data \mark-y
$mark-x = $map.data \mark-x
$zoom = $map.data \zoom
$icon = $map.find(\.marker).attr \src

styles =	[
	{
		"featureType": \all
		"elementType": \labels.text.fill
		"stylers": [{"color": \#ffffff}]
	}
	{
		"featureType": \all
		"elementType": \labels.text.stroke
		"stylers": [
			{"visibility": \on}
			{"color": \#2e3537}
			{	"weight": 2}
			{	"gamma": 0.84}
		]
	}
	{
		"featureType": \all
		"elementType": \labels.icon
		"stylers": [{"visibility": \off}]
	}
	{
		"featureType": \administrative
		"elementType": \geometry
		"stylers": [{"weight": 0.6	}]
	}
	{
		"featureType": \landscape
		"elementType": \geometry
		"stylers": [{"color": \#4c6374}]
	}
	{
		"featureType": \poi
		"elementType": \geometry
		"stylers": [{"color": \#667f90}]
	}
	{
		"featureType": \poi.park
		"elementType": \geometry
		"stylers": [{"color": \#667f90}]
	}
	{
		"featureType": \road
		"elementType": \geometry
		"stylers": [
			{"color": \#264258}
			{"lightness": -37	}
		]
	}
	{
		"featureType": \transit
		"elementType": \geometry
		"stylers": [{"color": \#5b7283}]
	}
	{
		"featureType": \water
		"elementType": \geometry
		"stylers": [{"color": \#66bcf7}]
	}
]

map = new GMaps(
	div: $map.selector
	lat: $pos-y
	lng: $pos-x
	zoom: $zoom
	zoomControl: true
	zoomControlOptions:
		position: google.maps.ControlPosition.LEFT_CENTER
	mapTypeControl: false
	scaleControl: false
	scrollwheel: false
)

map.addMarker(
	lat: $mark-y
	lng: $mark-x
	icon: $icon
	)

map.setOptions(styles: styles)

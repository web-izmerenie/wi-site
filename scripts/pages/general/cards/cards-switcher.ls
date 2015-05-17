/**
 * General page cards switcher control
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	jquery: $
	prelude: {each, map, Obj, obj-to-pairs, pairs-to-obj, reject, Str}
	\Snap.svg
}

s-class = \cards-switcher
bind-suffix = \.cards-switcher

h = 50px
offset-x = 25px
center-y = h / 2 |> Math.round
circle-r = 22px
point-r =  5px

# !!! side effects
set-jq-props = -> it |> each (-> it.$node = $ it.node)

on-resize = ({s, elems})!->

	total-w = s.$node.width!
	line-w = total-w |> (- offset-x * 2)

	elems.line.attr x2: total-w - offset-x

	elems.points.for-each (point, i)!->
		elems.points.length
		|> (- 1)
		|> (-> line-w / it)
		|> (* i)
		|> (+ offset-x)
		|> (-> point.attr cx: it)

export init = (cb)!->

	$cards-wrap = $ \.general-cards
	$controls = $cards-wrap.find \.controls

	links =
		$controls
			.find "ul.#{s-class} li a"
			.get!
			.map (-> $ it .attr \href)
			.map (-> it - /^[^#]+/) # just only anchors

	# remove old list
	$controls.find "ul.#{s-class}" .remove!

	s = Snap 0px, h
	s.attr class: s-class # set class from old list

	elems = {}

	# draw the line
	elems.line = s.line offset-x, center-y, 0, center-y .attr class: \line

	# small dots
	elems.points =
		links |> map (link)->
			s.circle 0, center-y, point-r
				.attr do
					class: \point
					\data-link : link
					\data-id : link |> Str.drop 1

	# big circle marker
	elems.marker = s.circle 0, center-y, circle-r

	# need opacity group, bacuse with simple alpha channel for elements
	# we can see "line" under "points" and it's a visual bug
	[elems.line] ++ elems.points
	|> s.group.apply s, _
	|> (.attr class: \opacity-group)

	# add jQuery-wrapped object properties
	[s]
	|> (++ elems
		|> obj-to-pairs
		|> reject (-> it.0 in <[points]>)
		|> map (-> it.1))
	|> (++ elems.points |> Obj.values)
	|> set-jq-props

	# append new svg switcher to controls
	s.append-to $controls.get 0

	# bind card-switcher resize handler (will be triggered from "size-calculator")
	s.$node.on "newsize#bind-suffix", (on-resize.bind null, {s, elems})

	cb!

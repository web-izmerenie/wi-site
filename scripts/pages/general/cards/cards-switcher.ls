/**
 * General page cards switcher control
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	jquery: $
	prelude: {each, map, Obj, obj-to-pairs, pairs-to-obj, reject, Str, camelize}
	\Snap.svg
}

s-class     = \cards-switcher
bind-suffix = \.cards-switcher

h        = 50px
offset-x = 25px
center-y = h / 2 |> Math.round
circle-r = 22px
point-r  = 5px

# !!! side effects
set-jq-props = -> it |> each (-> it.$node = $ it.node)

on-resize = ({s, elems, links})!->

	total-w = s.$node.width!
	line-w = total-w |> (- offset-x * 2)

	elems.line.attr x2: total-w - offset-x

	[..attr cx: offset-x for elems.mask-circles]

	for _, idx in links
		links.length
		|> (- 1)
		|> (-> line-w / it)
		|> (* idx)
		|> (+ offset-x)
		|> (x)!->
			[..attr cx: x for elems.points[idx].els]
			elems.numbers[idx].attr x: x

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

	elems = {

		# line   :: Snap.Element

		# points :: [Snap.Element]
		# hover-point :: Snap.Element

		# numbers :: [Snap.Element]
		# numbers-mask :: Snap.Element

		# marker :: Snap.Element
		# marker-mask-bg :: Snap.Element
		# marker-mask-c :: Snap.Element
		# marker-mask-g :: Snap.Group

		# opacity-group :: Snap.Group

		# mask-circles :: [Snap.Element]

		# point-stroke-fixer :: Snap.Element
	}

	elems.numbers = links.map (_, idx) ->
		s.text offset-x, (center-y + 1), "#{idx + 1}" .attr class: \text-number

	elems.numbers-mask = s.circle 0, center-y, circle-r .attr class: \numbers-mask

	elems.numbers
	|> s.group.apply s, _
	|> (.attr do
		class: \numbers-group
		mask: elems.numbers-mask)

	# hack-fix for points stroke
	elems.point-stroke-fixer = s.rect 0, 0, \100%, \100% .attr opacity: 0

	# draw the line
	elems.line = s.line offset-x, center-y, 0, center-y .attr class: \line

	# small dots
	elems.points =
		links |> map (link)->

			list =

				# small circle which we show to user
				s.circle 0, center-y, point-r .attr do
					class      : \point
					\data-link : link
					\data-id   : link |> Str.drop 1

				# big circle for big clickable area
				s.circle 0, center-y, circle-r .attr do
					class : \big-point

			list
			|> s.group.apply s, _
			|> (.els = list ; it)
			|> (.attr class: \points-group)

	# big circle marker
	elems.marker-mask-bg = s.rect 0, 0, \100%, \100% .attr class: \marker-mask-bg
	elems.marker-mask-c = s.circle 0, center-y, circle-r .attr class: \marker-mask-c
	elems.marker-mask-g = s.group elems.marker-mask-bg, elems.marker-mask-c

	# need opacity group, bacuse with simple alpha channel for elements
	# we can see "line" under "points" and it's a visual bug
	elems.opacity-group =
		[elems.point-stroke-fixer, elems.line] ++ elems.points
		|> s.group.apply s, _
		|> (.attr do
			class: \opacity-group
			mask: elems.marker-mask-g)

	# big circle marker
	elems.marker = s.circle 0, center-y, circle-r .attr class: \marker

	# add jQuery-wrapped object properties
	[s]
	|> (++ elems
		|> obj-to-pairs
		|> reject (-> it.0 in <[points]>)
		|> map (-> it.1))
	|> (++ elems.points |> Obj.values)
	|> set-jq-props

	elems.mask-circles =
		<[ marker marker-mask-c numbers-mask ]> .map -> elems[camelize it]

	# append new svg switcher to controls
	s.append-to $controls.get 0

	# bind card-switcher resize handler (will be triggered from "size-calculator")
	s.$node.on "newsize#bind-suffix", (on-resize.bind null, {s, elems, links})

	cb!

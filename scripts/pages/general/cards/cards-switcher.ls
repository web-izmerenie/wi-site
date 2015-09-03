/**
 * General page cards switcher control
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	jquery: $
	prelude: {each, map, Obj, obj-to-pairs, pairs-to-obj, reject, Str, camelize}
	\Snap.svg # also `mina` in global scope
	\../../../basics : {get-val}
}

const $w = $ window

const s-class     = \cards-switcher
const bind-suffix = \.cards-switcher

const h        = 50px
const offset-x = 25px
const center-y = h / 2 |> Math.round
const circle-r = 22px
const point-r  = 5px

const anim-speed = get-val \animation-speed |> (* 4)
const anim-curve = mina.easeinout

# !!! side effects
set-jq-props = -> it |> each (-> it.$node = $ it.node)

get-line-x1 = (line-w, links, idx)-->
	links.length
	|> (- 1)
	|> (-> line-w / it)
	|> (* idx)
	|> (+ offset-x)

# visual navigation
repos = ({s, elems, links, total-w, line-w})!->

	total-w ?= s.$node.width!
	line-w  ?= total-w |> (- offset-x * 2)

	s.active-idx
	|> get-line-x1 line-w, links
	|> (x)->
		elems.line.stop!.animate x1: x, anim-speed, anim-curve
		elems.dark-line.stop!.animate x2: x, anim-speed, anim-curve
		[..stop!.animate cx: x, anim-speed, anim-curve for elems.all-big-circles]

	for _, idx in links
		class-name = elems.points[idx].attr \class
		if idx <= s.active-idx
			if (class-name.index-of \dark) is (-1)
				elems.points[idx].attr class: "#class-name dark"
		else
			if (class-name.index-of \dark) isnt (-1)
				elems.points[idx].attr class: class-name - /dark/g - /  /g

on-resize = ({s, elems, links})!->

	total-w = s.$node.width!
	line-w = total-w |> (- offset-x * 2)

	elems.line.attr x2: total-w - offset-x

	for _, idx in links
		idx
		|> get-line-x1 line-w, links
		|> (x)!->
			[..attr cx: x for elems.points[idx].els]
			elems.numbers[idx].attr x: x

	repos {s, elems, links, total-w, line-w}

on-navigated = ({s, elems, links}, _, route)!->

	class-name = s.attr \class
	idx = links.index-of "##route"

	if idx is (-1)
		s.active-idx = 0
		if (class-name.index-of \invisible) is (-1)
			s.attr class: "#class-name invisible"
	else
		s.active-idx = idx
		if (class-name.index-of \invisible) isnt (-1)
			s.attr class: class-name - /invisible/g - /  /g

	repos {s, elems, links}

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
	s.attr class: "#{s-class} invisible" # set class from old list
	s.$node = $ s.node

	elems = {

		# line      :: Snap.Element
		# dark-line :: Snap.Element

		# points      :: [Snap.Element]
		# hover-point :: Snap.Element

		# numbers      :: [Snap.Element]
		# numbers-mask :: Snap.Element

		# marker         :: Snap.Element
		# marker-mask-bg :: Snap.Element
		# marker-mask-c  :: Snap.Element
		# marker-mask-g  :: Snap.Group

		# opacity-group :: Snap.Group

		# all-big-circles :: [Snap.Element]

		# point-stroke-fixer :: Snap.Element
	}

	elems.numbers = links.map (_, idx) ->
		s.text offset-x, (center-y + 1), "#{idx + 1}" .attr class: \text-number

	elems.numbers-mask = s.circle offset-x, center-y, circle-r .attr class: \numbers-mask

	elems.numbers
	|> s.group.apply s, _
	|> (.attr do
		class: \numbers-group
		mask: elems.numbers-mask)

	# hack-fix for points stroke
	elems.point-stroke-fixer = s.rect 0, 0, \100%, \100% .attr opacity: 0

	# draw the lines
	elems.dark-line = s.line offset-x, center-y, offset-x, center-y .attr class: \dark-line
	elems.line      = s.line offset-x, center-y, offset-x, center-y .attr class: \line

	# small dots
	elems.points =
		links |> map (link)->

			list =

				# small circle which we show to user
				s.circle 0, center-y, point-r .attr class: \point

				# big circle for big clickable area
				s.circle 0, center-y, circle-r .attr class: \big-point

			list
			|> s.group.apply s, _
			|> (.els = list ; it)
			|> (.click !->
				window.location.hash = link if window.location.hash isnt link
				$w.trigger \hash-nav-handle
			)
			|> (.attr class: \points-group)

	# big circle marker
	elems.marker-mask-bg = s.rect 0, 0, \100%, \100% .attr class: \marker-mask-bg
	elems.marker-mask-c = s.circle offset-x, center-y, circle-r .attr class: \marker-mask-c
	elems.marker-mask-g = s.group elems.marker-mask-bg, elems.marker-mask-c

	# need opacity group, bacuse with simple alpha channel for elements
	# we can see "line" under "points" and it's a visual bug
	elems.opacity-group =
		[
			elems.point-stroke-fixer
			elems.dark-line
			elems.line
		]
		|> (++ elems.points)
		|> s.group.apply s, _
		|> (.attr do
			class: \opacity-group
			mask: elems.marker-mask-g)

	# big circle marker
	elems.marker = s.circle offset-x, center-y, circle-r .attr class: \marker

	# add jQuery-wrapped object properties
	[s]
	|> (++ elems
		|> obj-to-pairs
		|> reject (-> it.0 in <[points]>)
		|> map (-> it.1))
	|> (++ elems.points |> Obj.values)
	|> set-jq-props

	elems.all-big-circles =
		<[ marker marker-mask-c numbers-mask ]> .map -> elems[camelize it]

	# append new svg switcher to controls
	s.append-to $controls.get 0

	# bind card-switcher resize handler (will be triggered from "size-calculator")
	on-resize.bind null, {s, elems, links}
	|> s.$node.on "newsize#bind-suffix", _

	on-navigated.bind null, {s, elems, links}
	|> $w.on "hash-navigated#bind-suffix", _
	$w.trigger "hash-navigated#bind-suffix", (window.location.hash.slice 1)

	cb |> set-timeout _, 0

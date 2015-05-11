/**
 * General page cards switcher control
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	jquery: $
	prelude: {}
	\Snap.svg
}

s-class = \cards-switcher
bind-suffix = \.cards-switcher

on-resize = ({s})!->
	#console.log s
	void

export init = (cb)!->

	$cards-wrap = $ \.general-cards
	$controls = $cards-wrap.find \.controls
	$cards-switcher = null

	links = $controls
		.find "ul.#{s-class} li a"
		.get!
		.map (-> $ it .attr \href)
		.map (-> it - /^[^#]+/) # just only anchors

	$controls.find "ul.#{s-class}" .remove!

	s = Snap 0px, 50px
	s.attr class: s-class
	$cards-switcher = $ s.node

	s.append-to $controls.get 0

	$cards-switcher.on "newsize#bind-suffix", (on-resize.bind null, {s})

	cb!

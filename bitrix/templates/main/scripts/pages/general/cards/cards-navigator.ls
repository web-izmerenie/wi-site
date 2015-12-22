require! {
	jquery: $
	prelude: { reject, filter, flip, all, map, each }
	\../../../basics : { get-val }
}

const $w = $ window

const $general-cards = $ \.general-cards
const $bgs-wrap      = $general-cards.find \.backgrounds
const $cards-wrap    = $general-cards.find \.cards
const $cards         = $cards-wrap.find \.card

const $bgs =
	$bgs-wrap.find \.card-bg
	|> reject (-> $ it .has-class \.card-bg-n0)
	|> $

const bind-suffix = \.cards-navigator
const anim-speed  = get-val \animation-speed |> (* 4)

$cards.css do
	opacity: 0
	left: \0%
	top: \0%
	z-index: 3

parse-int-flip = parse-int |> flip
delay = (set-timeout |> flip) 0

is-card-route   = (.index-of \card-n) >> (is 0)
is-card-visible = (.data \is-visible)

is-animating         = false # mutable, prevent animation bugs via checking this flag
last-card-route      = null  # mutable, updates every times when route changes and it's card route
last-routed-card-num = null  # mutable, updates after all animations end

# it fixes bug when we see area of left:100%
heal-cards-wrap = !-> $cards-wrap.scroll-top 0 .scroll-left 0

on-navigated = (_, route) !->
	return unless (route |> is-card-route) # do nothing if it's not card route
	do heal-cards-wrap
	last-card-route := route
	return if is-animating # prevent animation bugs

	# get int value of card number
	const routed-card-num = route - /^card-n/ |> parse-int-flip 10

	# show background of active card
	$bgs.remove-class \active
	$bgs.filter "[data-card-num=#routed-card-num]" .add-class \active

	# by default cards don't need be animated, so set this flag to true
	# to skip hidden cards from animation.
	$cards.data \animation-complete, true

	# here we need to get list of animated cards to check below
	# that we have something to animate and we need to wait
	# for all of this animations.
	# -- [Function]
	const anim-cards = filter (?) <| $cards |> map ->
		const $card = $ it
		const card-num = $card.attr \id |> (- /^card-n/) |> parse-int-flip 10
		const anim-opts = do ->

			if routed-card-num is card-num # active slide

				# no need to do anything if active card is already visible
				return null if ($card |> is-card-visible)

				# start position
				if card-num isnt 0
					$card.css left:
						if card-num > (last-routed-card-num ? 0)
							\100%
						else
							\-100%
				else if last-routed-card-num?
					$card.css top: \-100%

				# end position
				{ opacity: 1 } <<<
					if card-num is 0 then { top: \0% } else { left: \0% }

			else # inactive slide

				# no need to do anything if inactive slide is already invisible
				return null unless ($card |> is-card-visible)

				# end position
				{ opacity: 0 } <<<
					if card-num is 0
						top: \-100%
					else
						left:
							if card-num < routed-card-num then \-100% else \100%

		# if we don't need to animate it
		return null unless anim-opts?

		# if we need to animate it then we need to wait for this animation
		$card.data \animation-complete, false

		!-> $card.transition anim-opts, anim-speed, \in-out, !->

			$card
				.css anim-opts
				.css z-index: if anim-opts.opacity is 1 then 4 else 3
				.data \is-visible, (anim-opts.opacity is 1)
				.data \animation-complete, true

			do heal-cards-wrap

			if $cards |> all (-> $ it .data \animation-complete)
				is-animating := false
				last-routed-card-num := routed-card-num

				# if route changed when we animate cards then we need
				# to call navigation handler again
				if last-card-route isnt route
					!-> $w.trigger "hash-navigated#bind-suffix", (window.location.hash.slice 1)
					|> delay

	if anim-cards.length > 0
		is-animating := true
		anim-cards |> each delay

	do heal-cards-wrap

export init = (cb)!->
	do heal-cards-wrap
	$w.on "resize#bind-suffix", heal-cards-wrap
	$w.on "hash-navigated#bind-suffix", on-navigated
	$w.trigger "hash-navigated#bind-suffix", (window.location.hash.slice 1)
	cb |> delay

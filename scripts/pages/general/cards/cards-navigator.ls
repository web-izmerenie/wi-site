require! {
	jquery: $
	\../../../basics : {get-val}
}

const $w          = $ window
const anim-speed  = get-val \animation-speed |> (* 4)
const $cards-wrap = $ \.general-cards
const $main-card  = $cards-wrap.find \.card-n0
const $h1         = $main-card.find '.content h1'
const $start-btn  = $main-card.find \.next
const bind-suffix = \.cards-navigator

hide-it = !-> $ @ .hide!

hide-card-n0 = !->
	$h1.stop!.animate top: \-100%,
		anim-speed,
		hide-it

	$start-btn.stop!.animate top: \100%,
		anim-speed,
		hide-it

	$main-card.stop!.animate opacity: 0,
		anim-speed * 2,
		hide-it

show-card-n0 = !->
	$main-card.show!

on-navigated = (_, route) !->

	return if route |> (.index-of \card-n) |> (isnt 0)

	if route is \card-n0 then do show-card-n0 else do hide-card-n0

export init = (cb)!->
	$w.on "hash-navigated#bind-suffix", on-navigated
	$w.trigger "hash-navigated#bind-suffix", (window.location.hash.slice 1)
	cb |> set-timeout _, 0

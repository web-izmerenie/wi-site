/**
 * detect current anchor by scroll
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	jquery: $
	\jquery.timers
	prelude: {all, map, pairs-to-obj, obj-to-pairs, Obj, fold1}
	\../basics : {get-val}
	\../has-el-by-hash
}

const $w = $ window

const $html          = $ \html
const $page          = $ 'html, body'
const $body          = $html.find \body
const $header        = $body.find \header
const $menu          = $header.find \.menu
const $nav           = $menu.find \nav
const $nav-links     = $nav.find \a
const $height-helper = $header.find \.height-helper
const $general-cards = $body.find \.general-cards
const $cards         = $general-cards.find \.card

const main-page = $html.has-class \general-page

const bind-suffix = \.header-menu-auto-detect-current-anchor

const pathname = window.location.pathname

# for calculating how much down do we scrolled
const cur-page-hashes =
	[]
	|> (++ $cards |> map (->
		const $section = $ it
		[ "##{$section.attr \id}", { $section, $nav-link: null } ]
	))
	|> (++ $nav-links |> map (->
		[ it.hash, { $section: ($ it.hash), $nav-link: ($ it) } ]
	))
	|> pairs-to-obj

is-card-hash = (.index-of \#card-n) >> (is 0)

last-card-hash = null

hash-handler = (_, route) !->
	const route-with-hash = "##{route}"
	last-card-hash := route-with-hash if (route-with-hash |> is-card-hash)

scroll-handler = !->
	return if $body.has-class \scrolling

	const st   = $w.scroll-top!
	const stof = st + $height-helper.height!

	new-hash =
		cur-page-hashes

		# because for some reason invisible cards
		# have same offset top as current scroll top.
		|> Obj.filter (-> it.$section.is \:visible)

		|> Obj.map (.$section.offset!.top)
		|> Obj.filter (<= stof)
		|> obj-to-pairs
		|> fold1 ((a,b)-> if b.1 >= a.1 then b else a)
		|> ->
			return null unless it?
			const hash = it.0
			if hash |> is-card-hash
				\#card-n0
			else
				hash

	if new-hash? and new-hash isnt window.location.hash

		$nav-links.remove-class \active
		$nav-link = cur-page-hashes[new-hash].$nav-link
		$nav.stop-time \header-size-calc
		$nav-link.add-class \active if $nav-link?

		[ new-hash, window.location.hash ]
		|> all is-card-hash # both is card routes
		|> (not) # not both card routes
		|> !-> if it

			const hash-to-set =
				| (new-hash |> is-card-hash) and last-card-hash? => last-card-hash
				| otherwise => new-hash

			hash-to-set |> window.history.replace-state null, null, _
			$nav.one-time (\animation-speed |> get-val), \header-size-calc, !->
				$w.trigger \scroll.header-size-calc

$w
	.on "scroll#bind-suffix", scroll-handler
	.on "resize#bind-suffix", scroll-handler
	.on "hash-navigated#bind-suffix", hash-handler

$w.trigger "hash-navigated#bind-suffix", (window.location.hash.slice 1)

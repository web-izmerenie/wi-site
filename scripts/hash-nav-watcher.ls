/**
 * Hash navigation watcher
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	jquery: $
}

const interval = 500ms
const bind-suffix = \.hash-nav-watcher

const $w = $ window

timer-id   = null
last-route = null

watcher = !->

	current-route = window.location.hash.slice 1

	if current-route isnt last-route
		$w.trigger \hash-navigated, current-route
		last-route := current-route

export init = (init-route=null) !->

	throw new Error 'Already initialized' if timer-id?

	last-route := init-route if init-route?
	timer-id   := set-interval watcher, interval
	$w.on "hash-nav-handle#bind-suffix", watcher

export destroy = !->
	$w.off "hash-nav-handle#bind-suffix", watcher
	clear-interval timer-id
	timer-id   := null
	last-route := null

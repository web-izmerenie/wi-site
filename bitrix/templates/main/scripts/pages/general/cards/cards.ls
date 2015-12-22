/**
 * General page "cards" section
 *
 * @author Viacheslav Lotsmanov
 */

export init = (cb)!->

	require! {
		\./cards-switcher
		\./size-calculator
		\./cards-navigator
	}

	<-! cards-switcher.init
	<-! size-calculator.init
	<-! cards-navigator.init
	cb! if cb?

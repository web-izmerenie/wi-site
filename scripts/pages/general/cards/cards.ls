/**
 * General page "cards" section
 *
 * @author Viacheslav Lotsmanov
 */

export init = (cb)!->

	require! {
		\./cards-switcher
		\./size-calculator
	}

	<-! cards-switcher.init
	<-! size-calculator.init
	cb! if cb?

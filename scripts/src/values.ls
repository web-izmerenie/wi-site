/**
 * General values
 *
 * @author Viacheslav Lotsmanov
 */

module.exports.values =
	\animation-speed : 200ms
	\styles-load-timeout : 30sec
	\load-img-timeout : 15sec

	\workspace-ratio : [1920px, 1100px]
	\responsive-widths :
		extra-small: 460px
		small: 840px
		middle: 1000px
		big: 1920px
	\header :
		all:
			logo:
				left: 29px
		extra-small: {}
		small:
			width: 220px
			height: 96px
			helper-height: 70px
			logo:
				size: 41px
				text:
					margin-left: 14px
					font-size: 16px
					line-height: 18px
				scroll:
					left: 29px
					top: 15px
			call-menu:
				right: 22px
				top: 21px
				scale: 0.74
				margin-top: -14px
			nav:
				top: \50%
				right: 0
				item:
					font-size: 15px
					padding-top: 41px
		middle:
			height: 96px
			logo:
				size: 41px
				text:
					margin-left: 14px
					font-size: 16px
					line-height: 18px
			call-menu:
				right: 22px
				top: 21px
				scale: 0.74
			nav:
				top: 0
				right: 99px
				item:
					font-size: 15px
					padding-top: 41px
		big:
			height: 112px
			logo:
				size: 55px
				text:
					margin-left: 19px
					font-size: 22px
					line-height: 24px
			call-menu:
				right: 29px
				top: 28px
				scale: 1.0
			nav:
				top: 0
				right: 113px
				item:
					font-size: 18px
					padding-top: 45px
	\general-page :
		extra-small: {}
		small: {}
		middle:
			header-n1:
				font-size: 51px
				line-height: 50px
			header-n2:
				font-size: 16px
				line-height: 18px
				padding-top: 22px
			next:
				size: 69px
				margin-top: 42px
				scale: 0.69
				icon-top: 2px
		big:
			header-n1:
				font-size: 72px
				line-height: 73px
			header-n2:
				font-size: 24px
				line-height: 26px
				padding-top: 31px
			next:
				size: 100px
				margin-top: 62px
				scale: 1.0
				icon-top: 3px

module.exports.required =
	\lang
	\styles-href

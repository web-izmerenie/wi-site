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
		small: 840px
		middle: 1000px
		big: 1920px
	\header :
		all:
			logo:
				left: 29px
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
				top: 50 #%
				right: 0
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

module.exports.required =
	\lang
	\styles-href

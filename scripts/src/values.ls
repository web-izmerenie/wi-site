/**
 * General values
 *
 * @author Viacheslav Lotsmanov
 */

module.exports.values =
	\animation-speed : 200ms
	\styles-load-timeout : 30sec
	\load-img-timeout : 15sec

	\workspace-ratio : [1920, 1100]
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
		middle:
			height: 96px
			logo:
				size: 41px
				text:
					margin-left: 14px
					font-size: 16px
					line-height: 18px
		big:
			height: 112px
			logo:
				size: 55px
				text:
					margin-left: 19px
					font-size: 22px
					line-height: 24px

module.exports.required =
	\lang
	\styles-href

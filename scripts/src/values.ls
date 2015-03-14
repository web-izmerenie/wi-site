/**
 * General values
 *
 * @author Viacheslav Lotsmanov
 */

module.exports.values =
	\animation-speed : 200ms
	\styles-load-timeout : 30sec
	\load-img-timeout : 15sec
	\dynamic-api-interval : 500ms
	\yandex-maps-api-lang :
		ru: \ru_RU
		en: \en_US

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
				top: 0
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
	\footer :
		extra-small: {}
		small:
			copyright-text-block:
				margin-top: 64px
				padding-left: 40px
		middle:
			footer:
				height: 161px
			links:
				margin-top: 45px
			copyright-text-block:
				margin-top: 64px
				padding-left: 60px
			copyright-text-p:
				font-size: 14px
				line-height: 16px
		big:
			footer:
				height: 191px
			links:
				margin-top: 55px
			copyright-text-block:
				margin-top: 74px
				padding-left: 60px
			copyright-text-p:
				font-size: 16px
				line-height: 18px
	\general-page :
		extra-small: {}
		small:
			# contacts
			contacts-second-font-n1:
				font-size: 24px
				line-height: 26px
			contacts-second-font-n2:
				font-size: 16px
				line-height: 24px
			contacts-col-n1:
				padding-top: 48px
				padding-bottom: 50px
				padding-left: 38px
			contacts-col-n2:
				padding-right: 40px
				padding-top: 40px
				padding-bottom: 50px
			contacts-col-n2-label-submit:
				margin-top: 20px
			contacts-col-n2-label:
				margin-top: 10px
			contacts-col-n2-label-text:
				height: 45px
			contacts-col-n2-textarea:
				min-height: 125px
				padding-top: 11px
				padding-bottom: 11px
			contacts-col-n2-span:
				line-height: 45px
		middle:
			# top card
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

			# portfolio
			portfolio-title-block:
				padding-bottom: 56px
			portfolio-title-block-h2:
				font-size: 41px
				line-height: 43px
				padding-top: 68px
			portfolio-title-block-h3:
				font-size: 18px
				line-height: 20px
				padding-top: 22px
			portfolio-ul-li:
				height: 209px
			portfolio-ul-li-text-h3:
				font-size: 33px
				line-height: 35px
			portfolio-ul-li-text-h4:
				font-size: 16px
				line-height: 18px
			portfolio-ul-li-text-h3-h4:
				padding-top: 10px
			portfolio-more-block-a:
				font-size: 18px
				line-height: 20px
				padding-top: 99px
				margin-top: 51px
				margin-bottom: 40px
			portfolio-more-block-a-icon:
				scale: 0.65

			# contacts
			contacts-head:
				height: 380px
			contacts-h2:
				top: 79px
			contacts-h2-img:
				scale: 0.767
			contacts-second-font-n1:
				font-size: 30px
				line-height: 32px
			contacts-second-font-n2:
				font-size: 17px
				line-height: 24px
			contacts-col-n1-items:
				padding-left: 45px
			contacts-col-n1:
				padding-top: 48px
				padding-bottom: 60px
				padding-left: 38px
			contacts-col-n2:
				padding-right: 40px
				padding-top: 40px
				padding-bottom: 60px
			contacts-col-n2-label-submit:
				margin-top: 20px
			contacts-col-n2-label:
				margin-top: 10px
			contacts-col-n2-label-text:
				height: 50px
			contacts-col-n2-textarea:
				min-height: 130px
				padding-top: 12px
				padding-bottom: 12px
			contacts-col-n2-span:
				line-height: 50px
		big:
			# top card
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

			# portfolio
			portfolio-title-block:
				padding-bottom: 103px
			portfolio-title-block-h2:
				font-size: 62px
				line-height: 64px
				padding-top: 106px
			portfolio-title-block-h3:
				font-size: 22px
				line-height: 24px
				padding-top: 29px
			portfolio-ul-li:
				height: 330px
			portfolio-ul-li-text-h3:
				font-size: 52px
				line-height: 54px
			portfolio-ul-li-text-h4:
				font-size: 22px
				line-height: 24px
			portfolio-ul-li-text-h3-h4:
				padding-top: 19px
			portfolio-more-block-a:
				font-size: 24px
				line-height: 26px
				padding-top: 126px
				margin-top: 110px
				margin-bottom: 64px
			portfolio-more-block-a-icon:
				scale: 1.0

			# contacts
			contacts-head:
				height: 485px
			contacts-h2:
				top: 133px
			contacts-h2-img:
				scale: 1.0
			contacts-second-font-n1:
				font-size: 33px
				line-height: 35px
			contacts-second-font-n2:
				font-size: 21px
				line-height: 26px
			contacts-col-n1-items:
				padding-left: 60px
			contacts-col-n1:
				padding-top: 48px
				padding-bottom: 90px
				padding-left: 58px
			contacts-col-n2:
				padding-right: 60px
				padding-top: 50px
				padding-bottom: 90px
			contacts-col-n2-label-submit:
				margin-top: 30px
			contacts-col-n2-label:
				margin-top: 20px
			contacts-col-n2-label-text:
				height: 50px
			contacts-col-n2-textarea:
				min-height: 130px
				padding-top: 12px
				padding-bottom: 12px
			contacts-col-n2-span:
				line-height: 50px
	\blog-page :
		extra-small: {}
		small:
			blog:
				padding-left: 38px
				padding-right: 38px
		middle:
			blog:
				padding-left: 43px
				padding-right: 43px
			top-line:
				height: 79px
			col-right:
				width: 287px
		big:
			top-line:
				height: 85px
			col-right:
				width: 317px

module.exports.required =
	\lang
	\styles-href

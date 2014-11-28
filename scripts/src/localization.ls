/**
 * Site localization
 *
 * @encoding utf-8
 * @author Viacheslav Lotsmanov
 * @license GNU/AGPLv3
 * @see {@link https://github.com/web-izmerenie/wi-site/blob/master/LICENSE-AGPLv3|License}
 */

module.exports =
	\ru :
		\err :
			\styles :
				\path-detect : '''
					Произошла ошибка при инициализации сайта.

					Не удалось обнаружить путь до файла стилей CSS.
				'''
				\load-timeout : '''
					Произошла ошибка при инициализации сайта.

					Истекло время ожидания загрузки CSS стилей сайта.
				'''
				\xhr-load : '''
					Произошла ошибка при инициализации сайта.

					Не удалось загрузить стили сайта.

					Код ошибки: #ERROR_CODE#
				'''

			\preload-img : '''
				Произошла ошибка при инициализации сайта.

				Не удалось осуществить загрузку изображения.

				Путь до изображения: "#IMAGE_SRC#"

				Код ошибки: #ERROR_CODE#
			'''

			\preload-img-timeout : '''
				Произошла ошибка при инициализации сайта.

				Не удалось осуществить загрузку изображения.

				Истекло время ожидания.

				Путь до изображения: "#IMAGE_SRC#"
			'''

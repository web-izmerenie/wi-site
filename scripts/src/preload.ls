/**
 * Images preloading module
 *
 * @author Viacheslav Lotsmanov
 * @license GNU/AGPLv3
 * @see {@link https://github.com/web-izmerenie/wi-site/blob/master/LICENSE-AGPLv3|License}
 */

require! {
	prelude : _p
	jquery : $
	'./basics' : b
}

error = (xhr, status, err) !->
	if err is \timeout
		window.alert b.get-local-text \err, \styles, \load-timeout
	else
		window.alert b.get-local-text \err, \styles, \xhr-load,
			\#ERROR_CODE# : err

add-preload-to-dom = ($master, class-name) !->
	$new-el = $ '<ins/>', class: class-name
	$master.append $new-el

loaded-cb = (cb, loaded-list, matches) !->
	matches = matches |> _p.unique
	loaded-list = loaded-list |> _p.unique
	if _p.difference matches, loaded-list |> _p.empty
		set-timeout cb, 0

success = (data, cb) !->
	matches = data.match /(?!\.)(preload-[^\s]+)/g
	if not _p.is-type \Array
		set-timeout cb, 0
		return

	$master = $ '<div/>', class: \preloaders
	for class-name in matches
		$master.append ($ '<ins/>', class: class-name)
	$ \body .append $master

	loaded-list = []

	require! './lib/load_img' : LoadImg

	for class-name in matches
		src =
			$master.find \. + class-name .css \background-image
				.trim!
				.replace /^url\((.*?)\)$/i, \$1
				.trim!
				.replace /^'(.*?)'$/, \$1
				.replace /^"(.*?)"$/, \$1
		b.load-img src, let src, class-name then (err, img) !->
			if err
				if err instanceof LoadImg.exceptions.Timeout
					window.alert b.get-local-text \err, \preload-img-timeout, {
						\#IMAGE_SRC# : src
					}
					return
				window.alert b.get-local-text \err, \preload-img, {
					\#ERROR_CODE# : err.to-string!
					\#IMAGE_SRC# : src
				}
				return

			loaded-list.push class-name
			loaded-cb cb, loaded-list, matches

module.exports = (cb) !->
	$.ajax {
		cache: true
		url: b.get-val \styles-href
		dataType: \text
		timeout: (b.get-val \styles-load-timeout) * 1000
		type: \GET
		success: (data) !-> success data, cb
		error: error
	}

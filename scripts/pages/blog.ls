/**
 * Blog page behavior
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	jquery : $
	\../basics : {get-local-text}

	\./blog/size-calculator
	\./blog/icons-generator
}

$s = $ \.blog
$top-line = $s.find \.top-line
$search-form = $top-line.find \form.search-form
$search-form-q = $search-form.find \input:text

!->
	if !!($ @ .val!)
		$ @ .add-class \has-value
	else
		$ @ .remove-class \has-value
|> (-> $search-form-q.on \change, it .on \focus, it .on \blur, it .trigger \change)

$search-form.on \submit, ->
	window.alert get-local-text \err, \not-implemented-yet
	false

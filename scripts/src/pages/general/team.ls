/**
 * General page "team" section behavior
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	jquery: $
}

$s = $ \.team

$s
	.find \ul.people>li>a
	.on \click, -> false

/**
 * footer icons generator by SVG icons
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	jquery: $
	prelude: {each, map, pairs-to-obj}
	\Snap.svg
}

$footer = $ \footer
$links-block = $footer.find \.footer-links

<-! $links-block.find \ul>li .each
$li = $ @
$a = $li.find \a

icon-path = $li.attr \data-icon
return unless !!icon-path

(f) <-! Snap.load icon-path

icon = f.select \#icon .add-class \icon .attr id: ''

inactive = Snap! |> (.append f)
active = inactive.clone!
both = [inactive, active]

<[width height]> |> each (axis) !->
	both |> each (!-> it.select \svg .attr axis |> it.attr axis, _)

fill = (color, el) -->
	el
	|> (.select \.icon)
	|> (-> [it, it.select-all \*])
	|> each (!-> it.attr fill: color if it?)

colors = <[inactive active]>
	|> each (!-> $a.append "<ins class='#{it}' />")
	|> map (-> [it, $a.find "ins.#it" .css \color])
	|> pairs-to-obj

inactive.attr class: \inactive |> fill colors.inactive
active.attr class: \active |> fill colors.active

both |> each (.append-to $a.get 0)

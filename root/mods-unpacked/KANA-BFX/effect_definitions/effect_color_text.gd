class_name KANAEffectColorText
extends Effect


export(Color) var text_color


func get_text(colored := true) -> String:
	var text := .get_text(colored)

	if text_color:
		return "[color=#%s]%s[/color]" % [text_color.to_html(), text]

	return text

class_name KANAEffectRemoveEffect
extends Effect


export(Array, Resource) var effects_to_remove = []
export(bool) var remove_all_effects_with_this_custom_key := false
export(bool) var show_effect_text := true



static func get_id() -> String:
	return "kana_bfx_effect_remove_effect"


# Check if an effect with the same properties already exists.
func same_exists() -> bool:
	var keys: Array
	var custom_keys: Array

	for effect in effects_to_remove:
		keys.push_back(effect.key)
		custom_keys.push_back(effect.custom_key)

	for effect in RunData.effects[custom_key]:
		var current_keys: Array
		var current_custom_keys: Array

		for effect_to_remove in effect.effects_to_remove:
			current_keys.push_back(effect_to_remove.key)
			current_custom_keys.push_back(effect_to_remove.custom_key)

		if keys == current_keys and custom_keys == current_custom_keys:
			return true

	return false


func apply()-> void:
	if not RunData.effects[custom_key].has(self) and not same_exists():
		RunData.effects[custom_key].push_back(self)


func unapply() -> void:
	RunData.effects[custom_key].erase(self)


func get_text(colored := true) -> String:
	if show_effect_text:
		return .get_text(colored)

	return ""


func get_args() -> Array:
	var text_remove_effects := [""]

	for effect in effects_to_remove:
		text_remove_effects.push_back(effect.get_text())

	return [tr(key.to_upper()), "\n - ".join(text_remove_effects)]


func serialize() -> Dictionary:
	var serialized = .serialize()
	serialized.effects_to_remove = []
	serialized.remove_all_effects_with_this_custom_key = remove_all_effects_with_this_custom_key
	serialized.show_effect_text = show_effect_text

	for effect in effects_to_remove:
		# Skip if it is the same effect to prevent an infinite loop.
		if effect.get_id() == get_id():
			continue
		serialized.effects_to_remove.push_back(effect.serialize())

	return serialized


func deserialize_and_merge(serialized: Dictionary) -> void:
	.deserialize_and_merge(serialized)

	for serialized_effect in serialized.effects_to_remove:
		for effect in ItemService.effects:
			if effect.get_id() == serialized_effect.effect_id:
				var new_effect = effect.new()
				new_effect.deserialize_and_merge(serialized_effect)
				effects_to_remove.push_back(new_effect)
				break

	remove_all_effects_with_this_custom_key = serialized.remove_all_effects_with_this_custom_key
	show_effect_text = serialized.show_effect_text

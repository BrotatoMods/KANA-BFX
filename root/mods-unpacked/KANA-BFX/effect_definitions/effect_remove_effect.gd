class_name KANAEffectRemoveEffect
extends Effect


export (Array, Resource) var effects_to_remove = []


func apply()->void :
	RunData.effects[custom_key].push_back(self)


func unapply()->void :
	RunData.effects[custom_key].erase(self)


# -- NOT USED --
# func serialize() -> Dictionary:
# 	var serialized_effect: Dictionary = .serialize()
# 	serialized_effect.effects_to_remove = []

# 	for effect in effects_to_remove:
# 		serialized_effect.effects_to_remove.push_back(effect.serialize())

# 	return serialized_effect


# func deserialize_and_merge(effect: Dictionary) -> void:
# 	.deserialize_and_merge(effect)
# 	for serialized_effect_to_remove in effect.effects_to_remove:
# 		var new_effect := Effect.new()
# 		new_effect.deserialize_and_merge(serialized_effect_to_remove)
# 		effects_to_remove.push_back(new_effect)
# -- NOT USED --

class_name KANAEffectRemoveEffect
extends Effect


export (Array, Resource) var effects_to_remove = []


func apply() -> void:
	RunData.effects[custom_key].push_back([key, value, effects_to_remove])


func unapply()->void :
	RunData.effects[custom_key].erase([key, value, effects_to_remove])

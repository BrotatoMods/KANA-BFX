extends "res://singletons/item_service.gd"


func _ready() -> void:
	var effect_definitions: Array = load("res://mods-unpacked/KANA-BFX/effect_definitions/_effect_extra_serialization.tres").effects
	ItemService.effects.append_array(effect_definitions)

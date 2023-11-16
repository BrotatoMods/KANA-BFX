class_name KANAEffectSceneRef
extends Effect


export(PackedScene) var scene


static func get_id()->String:
	return "kana_bfx_effect_scene_ref"


func apply()->void :
	RunData.effects[custom_key].push_back(self)


func unapply()->void :
	RunData.effects[custom_key].erase(self)


func serialize() -> Dictionary:
	var serialized = .serialize()
	serialized.scene = scene.resource_path

	return serialized


func deserialize_and_merge(serialized: Dictionary) -> void:
	.deserialize_and_merge(serialized)
	scene = load(serialized.scene)

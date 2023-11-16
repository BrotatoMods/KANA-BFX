class_name KANAEffectSpawnEnemy
extends Effect

export(PackedScene) var enemy_scene


static func get_id()->String:
	return "kana_bfx_effect_spawn_enemy"


func apply()->void :
	RunData.effects[custom_key].push_back(self)


func unapply()->void :
	RunData.effects[custom_key].erase(self)


func get_args() -> Array:
	return [tr(key.to_upper())]


func serialize() -> Dictionary:
	var serialized = .serialize()
	if enemy_scene:
		serialized.enemy_scene = enemy_scene.resource_path

	return serialized


func deserialize_and_merge(serialized: Dictionary) -> void:
	.deserialize_and_merge(serialized)
	if serialized.has("enemy_scene"):
		enemy_scene = load(serialized.enemy_scene)

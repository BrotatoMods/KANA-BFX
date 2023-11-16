class_name KANAEffectProjectile
extends Effect

export(PackedScene) var projectile_scene
export(int) var projectile_count


static func get_id()->String:
	return "kana_bfx_effect_projectile"


func apply()->void :
	RunData.effects[custom_key].push_back(self)


func unapply()->void :
	RunData.effects[custom_key].erase(self)


func get_args() -> Array:
	return [tr(key.to_upper())]


func serialize() -> Dictionary:
	var serialized = .serialize()
	if projectile_scene:
		serialized.projectile_scene = projectile_scene.resource_path
	serialized.projectile_count = projectile_count

	return serialized


func deserialize_and_merge(serialized: Dictionary) -> void:
	.deserialize_and_merge(serialized)
	if serialized.has("projectile_scene"):
		projectile_scene = load(serialized.projectile_scene)
	projectile_count = serialized.projectile_count as int

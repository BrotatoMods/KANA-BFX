class_name KANAEffectProjectileGrid
extends Effect

export(PackedScene) var projectile_scene
export(int) var projectile_count


func apply()->void :
	RunData.effects[custom_key].push_back(self)


func unapply()->void :
	RunData.effects[custom_key].erase(self)

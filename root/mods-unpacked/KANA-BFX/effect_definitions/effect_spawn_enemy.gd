class_name KANAEffectSpawnEnemy
extends Effect

export(PackedScene) var enemy_scene


func apply()->void :
	RunData.effects[custom_key].push_back(self)


func unapply()->void :
	RunData.effects[custom_key].erase(self)

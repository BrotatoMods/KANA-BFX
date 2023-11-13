class_name KANAEffectSceneRef
extends Effect


export(PackedScene) var scene


func apply()->void :
	RunData.effects[custom_key].push_back(self)


func unapply()->void :
	RunData.effects[custom_key].erase(self)

class_name KANAEffectMoreData
extends Effect

export(Dictionary) var data


func apply()->void :
	RunData.effects[custom_key].push_back(self)


func unapply()->void :
	RunData.effects[custom_key].erase(self)

class_name KANAEffectResourceRef
extends Effect


export(Resource) var resource


func apply()->void :
	RunData.effects[custom_key].push_back(self)


func unapply()->void :
	RunData.effects[custom_key].erase(self)

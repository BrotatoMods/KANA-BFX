class_name KANAEffectConsumable
extends Effect


func apply()->void :
	if not custom_key == "" or storage_method == StorageMethod.KEY_VALUE:
		if StorageMethod.REPLACE:
			if RunData.effects[custom_key].empty():
				RunData.effects[custom_key].push_back([key, value])
			else:
				for effect_index in RunData.effects[custom_key].size():
					var effect: Array = RunData.effects[custom_key][effect_index]
					if effect[0] == key:
						effect = [key, value]
		else:
			RunData.effects[custom_key].push_back([key, value])
	elif storage_method == StorageMethod.REPLACE:
		base_value = RunData.effects[key]
		RunData.effects[key] = value
	else :
		RunData.effects[key] += value

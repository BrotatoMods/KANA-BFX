class_name KANAEffectMoreData
extends Effect

# ! Only use data that can be JSON.stringified 			   !
# ! If you need a reference to other things 			   !
# ! extend this Class and override the serialize functions !
export(Dictionary) var data


static func get_id()->String:
	return "kana_bfx_effect_more_data"


func apply()->void :
	RunData.effects[custom_key].push_back(self)


func unapply()->void :
	RunData.effects[custom_key].erase(self)


func get_args() -> Array:
	var displayed_key: String = key
	var data_values := []
	var base_args := [str(value), tr(displayed_key.to_upper())]

	for data_value in data.values():
		data_values.push_back(tr(data_value.to_upper()))

	base_args.append_array(data_values)

	return base_args


func serialize() -> Dictionary:
	var serialized = .serialize()
	serialized.data = data

	return serialized


func deserialize_and_merge(serialized: Dictionary) -> void:
	.deserialize_and_merge(serialized)
	data = serialized.data

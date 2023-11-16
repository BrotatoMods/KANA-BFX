class_name KANAEffectTimeSpan
extends Effect


export (int) var seconds


static func get_id()->String:
	return "kana_bfx_effect_time_span"


func apply()->void :
		RunData.effects[custom_key].push_back([key, value, seconds])

func unapply()->void :
		RunData.effects[custom_key].erase([key, value, seconds])


func serialize() -> Dictionary:
	var serialized = .serialize()
	serialized.seconds = seconds

	return serialized


func deserialize_and_merge(serialized: Dictionary) -> void:
	.deserialize_and_merge(serialized)
	seconds = serialized.seconds

class_name KANAEffectTimeSpan
extends Effect


export (int) var seconds


func apply()->void :
		RunData.effects[custom_key].push_back([key, value, seconds])

func unapply()->void :
		RunData.effects[custom_key].erase([key, value, seconds])

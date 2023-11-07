class_name KANAEffectWithFloatingText
extends Effect


func apply()->void :
	.apply()
	if not custom_key == "" or storage_method == StorageMethod.KEY_VALUE or storage_method == StorageMethod.REPLACE:
		return

	if key.begins_with("stat"):
		RunData.emit_signal("stat_added", key, value, 0.0)

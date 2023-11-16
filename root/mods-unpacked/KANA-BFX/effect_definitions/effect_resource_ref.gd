class_name KANAEffectResourceRef
extends Effect


export(Resource) var resource
export(Array, String) var effect_text_args


static func get_id()->String:
	return "kana_bfx_effect_resource_ref"


func apply()->void :
	RunData.effects[custom_key].push_back(self)


func unapply()->void :
	RunData.effects[custom_key].erase(self)


func get_args() -> Array:
	var args := []

	for arg in effect_text_args:
		var arg_prop
		var current_sub_arg = null
		var arg_split: Array = arg.split(".")

		if not arg_split.empty():
			for sub_arg in arg_split:
				if not current_sub_arg:
					current_sub_arg = self.get(sub_arg)
				else:
					current_sub_arg = current_sub_arg.get(sub_arg)

			arg_prop = current_sub_arg
		else:
			arg_prop = self.get(arg)

		args.push_back(tr(arg_prop.to_upper()))

	return args


func serialize() -> Dictionary:
	var serialized = .serialize()
	if resource:
		serialized.resource = resource.resource_path
	serialized.effect_text_args = effect_text_args

	return serialized


func deserialize_and_merge(serialized: Dictionary) -> void:
	.deserialize_and_merge(serialized)
	if serialized.has("resource"):
		resource = load(serialized.resource)
	effect_text_args = serialized.effect_text_args

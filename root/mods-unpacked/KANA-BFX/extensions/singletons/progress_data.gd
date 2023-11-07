extends "res://singletons/progress_data.gd"


func serialize_run_state() -> Dictionary:
	var serialized_run_state := .serialize_run_state()

	if not serialized_run_state.has_run_state:
		return serialized_run_state

	# I don't need to save this values because they get applied again.
	# So I can save me the work of serializing the effect array for this.
	serialized_run_state.effects["kana_bfx_remove_effect_after_consumable_collected"] = []

	return serialized_run_state

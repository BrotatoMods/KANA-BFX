extends "res://singletons/run_data.gd"


const KANA_BFX_RUN_DATA_LOG_NAME := "KANA-BFX:RunData"


func _ready()->void:
	_KANA_bfx_effect_keys_full_serialization()


func init_effects()->Dictionary:
	return _KANA_bfx_add_custom_effects(.init_effects())


# Adds BFX's custom effects to the vanilla set
func _KANA_bfx_add_custom_effects(vanilla_effects:Dictionary) -> Dictionary:
	ModLoaderLog.info("Adding custom effects", KANA_BFX_RUN_DATA_LOG_NAME)

	var custom_effects := {
		"kana_bfx_gain_stat_for_item_box_collected": [],
		"kana_bfx_gain_temp_stat_for_item_box_collected": [],
		"kana_bfx_port_to_opposite_side": 0,
		"kana_bfx_take_damage_on_turret_collision": 0,
		"kana_bfx_turret_follow_player": 0,
		"kana_bfx_turret_collide_with_player": 0,
		"kana_bfx_cant_stop_moving": 0,
		"kana_bfx_move_four_ways": 0,
		"kana_bfx_spawn_consumable_random_position": [],
		"kana_bfx_clear_consumable_on_wave_end": [],
		"kana_bfx_consumable_turrets": [],
		# Currently only on consumable collected
		"kana_bfx_temp_stat_for_time_amount": [],
		# Currently only on consumable collected
		"kana_bfx_temp_effect_for_time_amount": [],
	}

	return Utils.merge_dictionaries(vanilla_effects, custom_effects)


func _KANA_bfx_effect_keys_full_serialization() -> void:
	pass

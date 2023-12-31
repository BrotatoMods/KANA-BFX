extends "res://singletons/run_data.gd"


const KANA_BFX_RUN_DATA_LOG_NAME := "KANA-BFX:RunData"

var kana_bfx_effect_keys_full_serialization := [
	"kana_bfx_add_random_effect_on_consumable_collected",
	"kana_bfx_gain_stat_for_consumable_collected",
	"kana_bfx_gain_temp_stat_for_consumable_collected",
	"kana_bfx_spawn_projectile_grid_on_consumable_collected",
	"kana_bfx_spawn_projectile_in_front_of_player_on_consumable_collected",
	"kana_bfx_remove_effect_after_consumable_collected",
	"kana_bfx_replace_consumable",
	"kana_bfx_spawn_enemy_on_consumable_collected",
	"kana_bfx_temp_stat_for_time_amount",
	"kana_bfx_temp_effect_for_time_amount",
]


func _ready()->void:
	effect_keys_full_serialization.append_array(kana_bfx_effect_keys_full_serialization)


func init_effects()->Dictionary:
	return _KANA_bfx_add_custom_effects(.init_effects())


# Adds BFX's custom effects to the vanilla set
func _KANA_bfx_add_custom_effects(vanilla_effects:Dictionary) -> Dictionary:
	ModLoaderLog.info("Adding custom effects", KANA_BFX_RUN_DATA_LOG_NAME)

	var custom_effects := {
		"kana_bfx_gain_stat_for_consumable_collected": [],
		"kana_bfx_gain_temp_stat_for_consumable_collected": [],
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
		# Checks if the same effect is already applied
		"kana_bfx_remove_effect_after_consumable_collected": [],
		"kana_bfx_spawn_enemy_on_consumable_collected": [],
		# Currently only works well on the default map size
		"kana_bfx_spawn_projectile_grid_on_consumable_collected": [],
		# Don't remove this effect with "kana_bfx_remove_effect_after_consumable_collected"
		# It is removed by itself once the projectile has been spawned.
		# It will not work if you add it to "kana_bfx_remove_effect_after_consumable_collected"
		"kana_bfx_spawn_projectile_in_front_of_player_on_consumable_collected": [],
		# Checks if the same effect is already applied
		"kana_bfx_add_random_effect_on_consumable_collected": [],
		"kana_bfx_consumable_not_attract_on_low_health": [],
		# Base chance is defined in mod_main settings
		# The value is the multiplier for this base chance
		# If this gets too annoying, I might add an effect definition that allows floats
		# Weapon effect - setup in unit.gd take_damage()
		"kana_bfx_spawn_item_box_on_kill": 0,
		"kana_bfx_replace_consumable": [],
		"kana_bfx_always_attracted_consumable": []
	}

	return Utils.merge_dictionaries(vanilla_effects, custom_effects)

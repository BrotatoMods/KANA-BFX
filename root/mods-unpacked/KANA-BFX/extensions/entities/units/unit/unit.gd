extends "res://entities/units/unit/unit.gd"


onready var KANA_bfx = get_node("/root/ModLoader/KANA-BFX")


func take_damage(value:int, hitbox:Hitbox = null, dodgeable:bool = true, armor_applied:bool = true, custom_sound:Resource = null, base_effect_scale:float = 1.0) -> Array:
	var KANA_drop_item_box_on_kill_base_chance: float = KANA_bfx.settings.item_box_on_kill.base_chance
	var damage_data: Array = .take_damage(value, hitbox, dodgeable, armor_applied, custom_sound, base_effect_scale)

	if current_stats.health <= 0 and hitbox:
		for effect in hitbox.effects:
			if effect.key == "kana_bfx_spawn_item_box_on_kill":
				if randf() <= KANA_drop_item_box_on_kill_base_chance * RunData.effects["kana_bfx_spawn_item_box_on_kill"]:
					KANA_bfx.emit_signal("consumable_spawn_triggered", "consumable_item_box", global_position)

	return damage_data

extends "res://main.gd"


func _ready() -> void:
	_player.connect("KANA_player_border_collided", self, "_KANA_on_player_border_collided")


func KANA_get_opposite_collision_tile_position(tile_position: Vector2, direction: Vector2) -> Vector2:
	var current_zone = ZoneService.get_zone_data(RunData.current_zone).duplicate()
	var opposite_tile_position: Vector2
	var spawn_offset = 2

	if direction == Vector2(1, 0):
		opposite_tile_position = Vector2(current_zone.width - spawn_offset, tile_position.y)
	elif direction == Vector2(-1, 0):
		opposite_tile_position = Vector2(spawn_offset, tile_position.y)
	elif direction == Vector2(0, 1):
		opposite_tile_position = Vector2(tile_position.x, current_zone.height - spawn_offset)
	elif direction == Vector2(0, -1):
		opposite_tile_position = Vector2(tile_position.x, spawn_offset)

	var local_position: Vector2 = _tile_map_limits.map_to_world(opposite_tile_position)
	var global_position: Vector2 = _tile_map_limits.to_global(local_position)

	return global_position


func _KANA_on_player_border_collided(collision: KinematicCollision2D) -> void:
	if RunData.effects["kana_bfx_port_to_opposite_side"] == 0:
		return

	var tile_position_player: Vector2 = collision.collider.world_to_map(_player.position)
	var tile_position_collider: Vector2 = tile_position_player - collision.normal

	var opposite_position := KANA_get_opposite_collision_tile_position(tile_position_collider, collision.normal)

	_player.global_position = opposite_position


func on_consumable_picked_up(consumable: Node) -> void:
	.on_consumable_picked_up(consumable)

	# If a crate got collected
	if consumable.consumable_data.my_id == "consumable_item_box":
		var kana_bfx_gain_stat_for_item_box_collected: Array = RunData.effects["kana_bfx_gain_stat_for_item_box_collected"]
		var kana_bfx_gain_temp_stat_for_item_box_collected: Array = RunData.effects["kana_bfx_gain_temp_stat_for_item_box_collected"]

		# Check if the stat on crate collected effect is active
		if not kana_bfx_gain_stat_for_item_box_collected.empty():
			for effect in kana_bfx_gain_stat_for_item_box_collected:
				RunData.add_stat(effect[0], effect[1])

		if not kana_bfx_gain_temp_stat_for_item_box_collected.empty():
			for effect in kana_bfx_gain_temp_stat_for_item_box_collected:
				TempStats.add_stat(effect[0], effect[1])

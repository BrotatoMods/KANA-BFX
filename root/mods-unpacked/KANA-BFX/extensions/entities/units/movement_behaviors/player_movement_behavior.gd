extends "res://entities/units/movement_behaviors/player_movement_behavior.gd"


var kana_last_movement: Vector2


func get_movement():
	var kana_movement = .get_movement()

	if RunData.effects["kana_bfx_move_four_ways"]:
		kana_movement = Vector2.ZERO

		if Input.is_action_pressed('ui_right'):
			kana_movement = Vector2(1, 0)
		elif Input.is_action_pressed('ui_left'):
			kana_movement = Vector2(-1, 0)
		elif Input.is_action_pressed('ui_down'):
			kana_movement = Vector2(0, 1)
		elif Input.is_action_pressed('ui_up'):
			kana_movement = Vector2(0, -1)

	if RunData.effects["kana_bfx_cant_stop_moving"] and RunData.effects["kana_bfx_move_four_ways"] and kana_movement == Vector2.ZERO:
		if kana_last_movement == Vector2.ZERO:
			kana_movement = Vector2(1, 0)
		else :
			kana_movement = kana_last_movement

	if RunData.effects["kana_bfx_cant_stop_moving"] and kana_movement == Vector2.ZERO:
		if kana_last_movement == Vector2.ZERO:
			kana_movement = Vector2(rand_range( - PI, PI), rand_range( - PI, PI))
		else :
			kana_movement = kana_last_movement

	kana_last_movement = kana_movement

	return kana_movement

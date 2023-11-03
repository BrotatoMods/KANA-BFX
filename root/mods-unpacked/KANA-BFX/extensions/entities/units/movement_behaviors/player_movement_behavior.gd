extends "res://entities/units/movement_behaviors/player_movement_behavior.gd"


var kana_last_movement: Vector2


func get_movement():
	var movement = .get_movement()

	if RunData.effects["kana_bfx_move_four_ways"]:
		if Input.is_action_pressed('ui_right'):
			movement = Vector2(1, 0)
		elif Input.is_action_pressed('ui_left'):
			movement = Vector2(-1, 0)
		elif Input.is_action_pressed('ui_down'):
			movement = Vector2(0, 1)
		elif Input.is_action_pressed('ui_up'):
			movement = Vector2(0, -1)

	if RunData.effects["kana_bfx_cant_stop_moving"] and RunData.effects["kana_bfx_move_four_ways"] and movement == Vector2.ZERO:
		if kana_last_movement == Vector2.ZERO:
			movement = Vector2(1, 0)
		else :
			movement = kana_last_movement

	if RunData.effects["kana_bfx_cant_stop_moving"] and movement == Vector2.ZERO:
		if kana_last_movement == Vector2.ZERO:
			movement = Vector2(rand_range( - PI, PI), rand_range( - PI, PI))
		else :
			movement = kana_last_movement

	kana_last_movement = movement

	return movement

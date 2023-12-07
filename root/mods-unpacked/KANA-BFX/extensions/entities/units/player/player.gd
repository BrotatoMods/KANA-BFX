extends "res://entities/units/player/player.gd"


signal KANA_player_border_collided(collider)
signal KANA_player_turret_collided(collider)
signal KANA_last_position_updated(last_position)
signal KANA_forward_point_updated(forward_position)

var KANA_is_rigid_body_setup := false

var KANA_forward_point := Vector2.ZERO
var KANA_forward_point_offset_to_player := 350
var KANA_last_positions := []
var KANA_last_positions_length := 0
var KANA_wiggle_displacement := 15
var KANA_turret_collided_iframe_timer: Timer
var KANA_can_take_damage_from_turret := true
var KANA_can_take_damage_from_turret_cooldown := 0.4

onready var KANA_player_bfx := get_node("/root/ModLoader/KANA-BFX")


func _ready() -> void:
	KANA_rigid_body_setup()
	KANA_add_turret_collided_iframe_timer()
	KANA_update_last_positions_length()

	connect("KANA_player_turret_collided", self, "_KANA_on_player_turret_collided")
	KANA_turret_collided_iframe_timer.connect("timeout", self, "_KANA_on_turret_collided_iframe_timer_timeout")


func _physics_process(delta: float) -> void:
	for body in get_colliding_bodies():
		if body is Turret:
			emit_signal("KANA_player_turret_collided", body)


	if RunData.effects["kana_bfx_turret_follow_player"]:
		KANA_create_trailing_points()

	if not RunData.effects["kana_bfx_spawn_projectile_in_front_of_player_on_consumable_collected"].empty():
		KANA_create_forward_point()


func KANA_rigid_body_setup() -> void:
	if (
		RunData.effects.has("kana_bfx_turret_collide_with_player") and RunData.effects.kana_bfx_turret_collide_with_player == 1 or
		RunData.effects.has("kana_bfx_port_to_opposite_side") and RunData.effects.kana_bfx_port_to_opposite_side == 1
	):
		continuous_cd = RigidBody2D.CCD_MODE_CAST_SHAPE
		contact_monitor = true
		contacts_reported = 5

		KANA_is_rigid_body_setup = true


func KANA_add_turret_collided_iframe_timer() -> void:
	KANA_turret_collided_iframe_timer = Timer.new()
	KANA_turret_collided_iframe_timer.one_shot = true
	add_child(KANA_turret_collided_iframe_timer)


func KANA_update_last_positions_length():
	KANA_last_positions_length = KANA_player_bfx.state.walking_turrets.turrets.size() + 1


func KANA_create_forward_point() -> void:
	if _current_movement == Vector2.ZERO:
		KANA_forward_point = global_position
	else:
		KANA_forward_point = global_position + (_current_movement * KANA_forward_point_offset_to_player)
	emit_signal("KANA_forward_point_updated", KANA_forward_point)


func KANA_create_trailing_points() -> void:
	if KANA_last_positions.size() <= KANA_last_positions_length:
		KANA_add_point()
	else:
		KANA_last_positions.pop_front()
		KANA_add_point()


func _KANA_on_player_turret_collided(turret: Turret) -> void:
	if RunData.effects["kana_bfx_take_damage_on_turret_collision"] == 1:
		if KANA_can_take_damage_from_turret:
			var damage_base := 1
			var damage: int = round(damage_base * ((RunData.current_wave * 0.25) * RunData.current_run_accessibility_settings.damage))
			.take_damage(damage, null, false)
			KANA_can_take_damage_from_turret = false
			KANA_turret_collided_iframe_timer.start(KANA_can_take_damage_from_turret_cooldown)


func KANA_add_point() -> void:
	var KANA_last_positions_size = KANA_last_positions.size()

	# If there are no points yet just add the point and return
	if KANA_last_positions_size == 0:
		KANA_last_positions.push_back(global_position)
		return

	var distance := global_position.distance_to(KANA_last_positions[KANA_last_positions_size - 1])
	# Check if last point has a distance of 50
	if distance < 55:
		return

	# If boost is active wiggle the trail
	if KANA_player_bfx.state.walking_turrets.boost_active:
		# Depending on the movement direction displace x or y
		var current_movement_abs = _current_movement.abs()

		var wiggled_position := Vector2(
				global_position.x + KANA_wiggle_displacement * current_movement_abs.y,
				global_position.y + KANA_wiggle_displacement * current_movement_abs.x
				)

		KANA_wiggle_displacement = KANA_wiggle_displacement * -1

		KANA_last_positions.push_back(wiggled_position)
	else:
		KANA_last_positions.push_back(global_position)

	emit_signal("KANA_last_position_updated", global_position)


func _KANA_on_turret_collided_iframe_timer_timeout() -> void:
	KANA_can_take_damage_from_turret = true


func _on_ItemAttractArea_area_entered(area: Area2D) -> void:
	._on_ItemAttractArea_area_entered(area)
	if area is Consumable:
		var KANA_consumable: Consumable = area

		if not RunData.effects["kana_bfx_consumable_not_attract_on_low_health"].empty():
			for effect in RunData.effects["kana_bfx_consumable_not_attract_on_low_health"]:
				var key: String = effect[0]
				var value: int = effect[1]

				if key == KANA_consumable.consumable_data.my_id:
					var _kana_last_consumable_in_range: Consumable = consumables_in_range.pop_back()
					KANA_consumable.attracted_by = null

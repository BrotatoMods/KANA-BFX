extends "res://entities/units/player/player.gd"


signal KANA_player_border_collided(collider)
signal KANA_player_turret_collided(collider)


func _ready() -> void:
	connect("KANA_player_turret_collided", self, "_KANA_on_player_turret_collided")


func _physics_process(delta: float) -> void:
	var collision := get_last_slide_collision()
	if collision and collision.collider is MyTileMapLimits:
		emit_signal("KANA_player_border_collided", collision)
	if collision and collision.collider is Turret:
		emit_signal("KANA_player_turret_collided", collision)


func _KANA_on_player_turret_collided(collision: KinematicCollision2D) -> void:
	if RunData.effects["kana_bfx_take_damage_on_turret_collision"] == 1:
		.take_damage(1)

extends Node2D


var air_particles_visually_hidden := true

onready var animation_player: AnimationPlayer = $"%AnimationPlayer"


func show_air_particles() -> void:
	animation_player.play("fade_in")
	air_particles_visually_hidden = false


func hide_air_particles() -> void:
	animation_player.play("fade_out")
	air_particles_visually_hidden = true

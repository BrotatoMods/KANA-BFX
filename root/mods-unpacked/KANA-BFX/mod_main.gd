extends Node


signal consumable_spawn_triggered(id, position)

const KANA_BFX_DIR := "KANA-BFX"
const KANA_BFX_LOG_NAME := "KANA-BFX:ModMain"

var mod_dir_path := ""
var extensions_dir_path := ""
var translations_dir_path := ""

var walking_turrets_debug_point: PackedScene = preload("res://mods-unpacked/KANA-BFX/content/walking_turrets/debug_point.tscn")
var walking_turrets_debug_points: Node
var boost_timer: Timer

var state := {
	"walking_turrets": {
		"turrets": [],
		"debug_points": [],
		"boost_active": false,
	},
	"spawn_consumable": {},
}

var settings := {
	"walking_turrets": {
		"show_debug_points": false,
		# This will exclude all structures with wandering bot effect
		"exclude_wandering_bot": true,
		# Exclude structures based on there effects text_key.
		"exclude_effect_text_key": ["effect_garden"]
	},
	"item_box_on_kill": {
		"base_chance": 0.0025, # 0.25%
	}
}


func _init(modLoader = ModLoader) -> void:
	mod_dir_path = ModLoaderMod.get_unpacked_dir().plus_file(KANA_BFX_DIR)
	# Add extensions
	install_script_extensions()
	# Add translations
	add_translations()


func install_script_extensions() -> void:
	extensions_dir_path = mod_dir_path.plus_file("extensions")
	ModLoaderMod.install_script_extension(extensions_dir_path.plus_file("main.gd"))
	ModLoaderMod.install_script_extension(extensions_dir_path.plus_file("singletons/run_data.gd"))
	ModLoaderMod.install_script_extension(extensions_dir_path.plus_file("entities/units/player/player.gd"))
	ModLoaderMod.install_script_extension(extensions_dir_path.plus_file("entities/structures/turret/turret.gd"))
	ModLoaderMod.install_script_extension(extensions_dir_path.plus_file("entities/units/movement_behaviors/player_movement_behavior.gd"))
	ModLoaderMod.install_script_extension(extensions_dir_path.plus_file("singletons/progress_data.gd"))
	ModLoaderMod.install_script_extension(extensions_dir_path.plus_file("entities/units/unit/unit.gd"))


func add_translations() -> void:
	translations_dir_path = mod_dir_path.plus_file("translations")
	ModLoaderMod.add_translation("res://mods-unpacked/KANA-BFX/translations/translation.en.translation")
	ModLoaderMod.add_translation("res://mods-unpacked/KANA-BFX/translations/translation.de.translation")


func _ready() -> void:
	boost_timer = Timer.new()
	boost_timer.one_shot = true
	add_child(boost_timer)
	boost_timer.connect("timeout", self, "_on_boost_timer_timeout")


func KANA_activate_walking_turret_boost(seconds: int) -> void:
	if not state.walking_turrets.boost_active:
		state.walking_turrets.boost_active = true

		if boost_timer.is_stopped():
			boost_timer.start(seconds)
	else:
		boost_timer.start(seconds)


func _on_boost_timer_timeout() -> void:
	state.walking_turrets.boost_active = false

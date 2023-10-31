extends Node


const KANA_BFX_DIR := "KANA-BFX"
const KANA_BFX_LOG_NAME := "KANA-BFX:Main"

var mod_dir_path := ""
var extensions_dir_path := ""
var translations_dir_path := ""


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



func add_translations() -> void:
	translations_dir_path = mod_dir_path.plus_file("translations")
	ModLoaderMod.add_translation("res://mods-unpacked/KANA-BFX/translations/translation.en.translation")
	ModLoaderMod.add_translation("res://mods-unpacked/KANA-BFX/translations/translation.de.translation")


func _ready() -> void:
	pass



class_name KANAProjectileGridSpawner
extends Object


var pillar_projectile_scene: PackedScene = preload("res://projectiles/pillar_enemy/pillar_projectile.tscn")
# TODO: Add a function to generate this for non default sized maps
var global_tile_positions_default_map := [Vector2(0, 0), Vector2(64, 0), Vector2(128, 0), Vector2(192, 0), Vector2(256, 0), Vector2(320, 0), Vector2(384, 0), Vector2(448, 0), Vector2(512, 0), Vector2(576, 0), Vector2(640, 0), Vector2(704, 0), Vector2(768, 0), Vector2(832, 0), Vector2(896, 0), Vector2(960, 0), Vector2(1024, 0), Vector2(1088, 0), Vector2(1152, 0), Vector2(1216, 0), Vector2(1280, 0), Vector2(1344, 0), Vector2(1408, 0), Vector2(1472, 0), Vector2(1536, 0), Vector2(1600, 0), Vector2(1664, 0), Vector2(1728, 0), Vector2(1792, 0), Vector2(1856, 0), Vector2(1920, 0), Vector2(1984, 0), Vector2(0, 64), Vector2(64, 64), Vector2(128, 64), Vector2(192, 64), Vector2(256, 64), Vector2(320, 64), Vector2(384, 64), Vector2(448, 64), Vector2(512, 64), Vector2(576, 64), Vector2(640, 64), Vector2(704, 64), Vector2(768, 64), Vector2(832, 64), Vector2(896, 64), Vector2(960, 64), Vector2(1024, 64), Vector2(1088, 64), Vector2(1152, 64), Vector2(1216, 64), Vector2(1280, 64), Vector2(1344, 64), Vector2(1408, 64), Vector2(1472, 64), Vector2(1536, 64), Vector2(1600, 64), Vector2(1664, 64), Vector2(1728, 64), Vector2(1792, 64), Vector2(1856, 64), Vector2(1920, 64), Vector2(1984, 64), Vector2(0, 128), Vector2(64, 128), Vector2(128, 128), Vector2(192, 128), Vector2(256, 128), Vector2(320, 128), Vector2(384, 128), Vector2(448, 128), Vector2(512, 128), Vector2(576, 128), Vector2(640, 128), Vector2(704, 128), Vector2(768, 128), Vector2(832, 128), Vector2(896, 128), Vector2(960, 128), Vector2(1024, 128), Vector2(1088, 128), Vector2(1152, 128), Vector2(1216, 128), Vector2(1280, 128), Vector2(1344, 128), Vector2(1408, 128), Vector2(1472, 128), Vector2(1536, 128), Vector2(1600, 128), Vector2(1664, 128), Vector2(1728, 128), Vector2(1792, 128), Vector2(1856, 128), Vector2(1920, 128), Vector2(1984, 128), Vector2(0, 192), Vector2(64, 192), Vector2(128, 192), Vector2(192, 192), Vector2(256, 192), Vector2(320, 192), Vector2(384, 192), Vector2(448, 192), Vector2(512, 192), Vector2(576, 192), Vector2(640, 192), Vector2(704, 192), Vector2(768, 192), Vector2(832, 192), Vector2(896, 192), Vector2(960, 192), Vector2(1024, 192), Vector2(1088, 192), Vector2(1152, 192), Vector2(1216, 192), Vector2(1280, 192), Vector2(1344, 192), Vector2(1408, 192), Vector2(1472, 192), Vector2(1536, 192), Vector2(1600, 192), Vector2(1664, 192), Vector2(1728, 192), Vector2(1792, 192), Vector2(1856, 192), Vector2(1920, 192), Vector2(1984, 192), Vector2(0, 256), Vector2(64, 256), Vector2(128, 256), Vector2(192, 256), Vector2(256, 256), Vector2(320, 256), Vector2(384, 256), Vector2(448, 256), Vector2(512, 256), Vector2(576, 256), Vector2(640, 256), Vector2(704, 256), Vector2(768, 256), Vector2(832, 256), Vector2(896, 256), Vector2(960, 256), Vector2(1024, 256), Vector2(1088, 256), Vector2(1152, 256), Vector2(1216, 256), Vector2(1280, 256), Vector2(1344, 256), Vector2(1408, 256), Vector2(1472, 256), Vector2(1536, 256), Vector2(1600, 256), Vector2(1664, 256), Vector2(1728, 256), Vector2(1792, 256), Vector2(1856, 256), Vector2(1920, 256), Vector2(1984, 256), Vector2(0, 320), Vector2(64, 320), Vector2(128, 320), Vector2(192, 320), Vector2(256, 320), Vector2(320, 320), Vector2(384, 320), Vector2(448, 320), Vector2(512, 320), Vector2(576, 320), Vector2(640, 320), Vector2(704, 320), Vector2(768, 320), Vector2(832, 320), Vector2(896, 320), Vector2(960, 320), Vector2(1024, 320), Vector2(1088, 320), Vector2(1152, 320), Vector2(1216, 320), Vector2(1280, 320), Vector2(1344, 320), Vector2(1408, 320), Vector2(1472, 320), Vector2(1536, 320), Vector2(1600, 320), Vector2(1664, 320), Vector2(1728, 320), Vector2(1792, 320), Vector2(1856, 320), Vector2(1920, 320), Vector2(1984, 320), Vector2(0, 384), Vector2(64, 384), Vector2(128, 384), Vector2(192, 384), Vector2(256, 384), Vector2(320, 384), Vector2(384, 384), Vector2(448, 384), Vector2(512, 384), Vector2(576, 384), Vector2(640, 384), Vector2(704, 384), Vector2(768, 384), Vector2(832, 384), Vector2(896, 384), Vector2(960, 384), Vector2(1024, 384), Vector2(1088, 384), Vector2(1152, 384), Vector2(1216, 384), Vector2(1280, 384), Vector2(1344, 384), Vector2(1408, 384), Vector2(1472, 384), Vector2(1536, 384), Vector2(1600, 384), Vector2(1664, 384), Vector2(1728, 384), Vector2(1792, 384), Vector2(1856, 384), Vector2(1920, 384), Vector2(1984, 384), Vector2(0, 448), Vector2(64, 448), Vector2(128, 448), Vector2(192, 448), Vector2(256, 448), Vector2(320, 448), Vector2(384, 448), Vector2(448, 448), Vector2(512, 448), Vector2(576, 448), Vector2(640, 448), Vector2(704, 448), Vector2(768, 448), Vector2(832, 448), Vector2(896, 448), Vector2(960, 448), Vector2(1024, 448), Vector2(1088, 448), Vector2(1152, 448), Vector2(1216, 448), Vector2(1280, 448), Vector2(1344, 448), Vector2(1408, 448), Vector2(1472, 448), Vector2(1536, 448), Vector2(1600, 448), Vector2(1664, 448), Vector2(1728, 448), Vector2(1792, 448), Vector2(1856, 448), Vector2(1920, 448), Vector2(1984, 448), Vector2(0, 512), Vector2(64, 512), Vector2(128, 512), Vector2(192, 512), Vector2(256, 512), Vector2(320, 512), Vector2(384, 512), Vector2(448, 512), Vector2(512, 512), Vector2(576, 512), Vector2(640, 512), Vector2(704, 512), Vector2(768, 512), Vector2(832, 512), Vector2(896, 512), Vector2(960, 512), Vector2(1024, 512), Vector2(1088, 512), Vector2(1152, 512), Vector2(1216, 512), Vector2(1280, 512), Vector2(1344, 512), Vector2(1408, 512), Vector2(1472, 512), Vector2(1536, 512), Vector2(1600, 512), Vector2(1664, 512), Vector2(1728, 512), Vector2(1792, 512), Vector2(1856, 512), Vector2(1920, 512), Vector2(1984, 512), Vector2(0, 576), Vector2(64, 576), Vector2(128, 576), Vector2(192, 576), Vector2(256, 576), Vector2(320, 576), Vector2(384, 576), Vector2(448, 576), Vector2(512, 576), Vector2(576, 576), Vector2(640, 576), Vector2(704, 576), Vector2(768, 576), Vector2(832, 576), Vector2(896, 576), Vector2(960, 576), Vector2(1024, 576), Vector2(1088, 576), Vector2(1152, 576), Vector2(1216, 576), Vector2(1280, 576), Vector2(1344, 576), Vector2(1408, 576), Vector2(1472, 576), Vector2(1536, 576), Vector2(1600, 576), Vector2(1664, 576), Vector2(1728, 576), Vector2(1792, 576), Vector2(1856, 576), Vector2(1920, 576), Vector2(1984, 576), Vector2(0, 640), Vector2(64, 640), Vector2(128, 640), Vector2(192, 640), Vector2(256, 640), Vector2(320, 640), Vector2(384, 640), Vector2(448, 640), Vector2(512, 640), Vector2(576, 640), Vector2(640, 640), Vector2(704, 640), Vector2(768, 640), Vector2(832, 640), Vector2(896, 640), Vector2(960, 640), Vector2(1024, 640), Vector2(1088, 640), Vector2(1152, 640), Vector2(1216, 640), Vector2(1280, 640), Vector2(1344, 640), Vector2(1408, 640), Vector2(1472, 640), Vector2(1536, 640), Vector2(1600, 640), Vector2(1664, 640), Vector2(1728, 640), Vector2(1792, 640), Vector2(1856, 640), Vector2(1920, 640), Vector2(1984, 640), Vector2(0, 704), Vector2(64, 704), Vector2(128, 704), Vector2(192, 704), Vector2(256, 704), Vector2(320, 704), Vector2(384, 704), Vector2(448, 704), Vector2(512, 704), Vector2(576, 704), Vector2(640, 704), Vector2(704, 704), Vector2(768, 704), Vector2(832, 704), Vector2(896, 704), Vector2(960, 704), Vector2(1024, 704), Vector2(1088, 704), Vector2(1152, 704), Vector2(1216, 704), Vector2(1280, 704), Vector2(1344, 704), Vector2(1408, 704), Vector2(1472, 704), Vector2(1536, 704), Vector2(1600, 704), Vector2(1664, 704), Vector2(1728, 704), Vector2(1792, 704), Vector2(1856, 704), Vector2(1920, 704), Vector2(1984, 704), Vector2(0, 768), Vector2(64, 768), Vector2(128, 768), Vector2(192, 768), Vector2(256, 768), Vector2(320, 768), Vector2(384, 768), Vector2(448, 768), Vector2(512, 768), Vector2(576, 768), Vector2(640, 768), Vector2(704, 768), Vector2(768, 768), Vector2(832, 768), Vector2(896, 768), Vector2(960, 768), Vector2(1024, 768), Vector2(1088, 768), Vector2(1152, 768), Vector2(1216, 768), Vector2(1280, 768), Vector2(1344, 768), Vector2(1408, 768), Vector2(1472, 768), Vector2(1536, 768), Vector2(1600, 768), Vector2(1664, 768), Vector2(1728, 768), Vector2(1792, 768), Vector2(1856, 768), Vector2(1920, 768), Vector2(1984, 768), Vector2(0, 832), Vector2(64, 832), Vector2(128, 832), Vector2(192, 832), Vector2(256, 832), Vector2(320, 832), Vector2(384, 832), Vector2(448, 832), Vector2(512, 832), Vector2(576, 832), Vector2(640, 832), Vector2(704, 832), Vector2(768, 832), Vector2(832, 832), Vector2(896, 832), Vector2(960, 832), Vector2(1024, 832), Vector2(1088, 832), Vector2(1152, 832), Vector2(1216, 832), Vector2(1280, 832), Vector2(1344, 832), Vector2(1408, 832), Vector2(1472, 832), Vector2(1536, 832), Vector2(1600, 832), Vector2(1664, 832), Vector2(1728, 832), Vector2(1792, 832), Vector2(1856, 832), Vector2(1920, 832), Vector2(1984, 832), Vector2(0, 896), Vector2(64, 896), Vector2(128, 896), Vector2(192, 896), Vector2(256, 896), Vector2(320, 896), Vector2(384, 896), Vector2(448, 896), Vector2(512, 896), Vector2(576, 896), Vector2(640, 896), Vector2(704, 896), Vector2(768, 896), Vector2(832, 896), Vector2(896, 896), Vector2(960, 896), Vector2(1024, 896), Vector2(1088, 896), Vector2(1152, 896), Vector2(1216, 896), Vector2(1280, 896), Vector2(1344, 896), Vector2(1408, 896), Vector2(1472, 896), Vector2(1536, 896), Vector2(1600, 896), Vector2(1664, 896), Vector2(1728, 896), Vector2(1792, 896), Vector2(1856, 896), Vector2(1920, 896), Vector2(1984, 896), Vector2(0, 960), Vector2(64, 960), Vector2(128, 960), Vector2(192, 960), Vector2(256, 960), Vector2(320, 960), Vector2(384, 960), Vector2(448, 960), Vector2(512, 960), Vector2(576, 960), Vector2(640, 960), Vector2(704, 960), Vector2(768, 960), Vector2(832, 960), Vector2(896, 960), Vector2(960, 960), Vector2(1024, 960), Vector2(1088, 960), Vector2(1152, 960), Vector2(1216, 960), Vector2(1280, 960), Vector2(1344, 960), Vector2(1408, 960), Vector2(1472, 960), Vector2(1536, 960), Vector2(1600, 960), Vector2(1664, 960), Vector2(1728, 960), Vector2(1792, 960), Vector2(1856, 960), Vector2(1920, 960), Vector2(1984, 960), Vector2(0, 1024), Vector2(64, 1024), Vector2(128, 1024), Vector2(192, 1024), Vector2(256, 1024), Vector2(320, 1024), Vector2(384, 1024), Vector2(448, 1024), Vector2(512, 1024), Vector2(576, 1024), Vector2(640, 1024), Vector2(704, 1024), Vector2(768, 1024), Vector2(832, 1024), Vector2(896, 1024), Vector2(960, 1024), Vector2(1024, 1024), Vector2(1088, 1024), Vector2(1152, 1024), Vector2(1216, 1024), Vector2(1280, 1024), Vector2(1344, 1024), Vector2(1408, 1024), Vector2(1472, 1024), Vector2(1536, 1024), Vector2(1600, 1024), Vector2(1664, 1024), Vector2(1728, 1024), Vector2(1792, 1024), Vector2(1856, 1024), Vector2(1920, 1024), Vector2(1984, 1024), Vector2(0, 1088), Vector2(64, 1088), Vector2(128, 1088), Vector2(192, 1088), Vector2(256, 1088), Vector2(320, 1088), Vector2(384, 1088), Vector2(448, 1088), Vector2(512, 1088), Vector2(576, 1088), Vector2(640, 1088), Vector2(704, 1088), Vector2(768, 1088), Vector2(832, 1088), Vector2(896, 1088), Vector2(960, 1088), Vector2(1024, 1088), Vector2(1088, 1088), Vector2(1152, 1088), Vector2(1216, 1088), Vector2(1280, 1088), Vector2(1344, 1088), Vector2(1408, 1088), Vector2(1472, 1088), Vector2(1536, 1088), Vector2(1600, 1088), Vector2(1664, 1088), Vector2(1728, 1088), Vector2(1792, 1088), Vector2(1856, 1088), Vector2(1920, 1088), Vector2(1984, 1088), Vector2(0, 1152), Vector2(64, 1152), Vector2(128, 1152), Vector2(192, 1152), Vector2(256, 1152), Vector2(320, 1152), Vector2(384, 1152), Vector2(448, 1152), Vector2(512, 1152), Vector2(576, 1152), Vector2(640, 1152), Vector2(704, 1152), Vector2(768, 1152), Vector2(832, 1152), Vector2(896, 1152), Vector2(960, 1152), Vector2(1024, 1152), Vector2(1088, 1152), Vector2(1152, 1152), Vector2(1216, 1152), Vector2(1280, 1152), Vector2(1344, 1152), Vector2(1408, 1152), Vector2(1472, 1152), Vector2(1536, 1152), Vector2(1600, 1152), Vector2(1664, 1152), Vector2(1728, 1152), Vector2(1792, 1152), Vector2(1856, 1152), Vector2(1920, 1152), Vector2(1984, 1152), Vector2(0, 1216), Vector2(64, 1216), Vector2(128, 1216), Vector2(192, 1216), Vector2(256, 1216), Vector2(320, 1216), Vector2(384, 1216), Vector2(448, 1216), Vector2(512, 1216), Vector2(576, 1216), Vector2(640, 1216), Vector2(704, 1216), Vector2(768, 1216), Vector2(832, 1216), Vector2(896, 1216), Vector2(960, 1216), Vector2(1024, 1216), Vector2(1088, 1216), Vector2(1152, 1216), Vector2(1216, 1216), Vector2(1280, 1216), Vector2(1344, 1216), Vector2(1408, 1216), Vector2(1472, 1216), Vector2(1536, 1216), Vector2(1600, 1216), Vector2(1664, 1216), Vector2(1728, 1216), Vector2(1792, 1216), Vector2(1856, 1216), Vector2(1920, 1216), Vector2(1984, 1216), Vector2(0, 1280), Vector2(64, 1280), Vector2(128, 1280), Vector2(192, 1280), Vector2(256, 1280), Vector2(320, 1280), Vector2(384, 1280), Vector2(448, 1280), Vector2(512, 1280), Vector2(576, 1280), Vector2(640, 1280), Vector2(704, 1280), Vector2(768, 1280), Vector2(832, 1280), Vector2(896, 1280), Vector2(960, 1280), Vector2(1024, 1280), Vector2(1088, 1280), Vector2(1152, 1280), Vector2(1216, 1280), Vector2(1280, 1280), Vector2(1344, 1280), Vector2(1408, 1280), Vector2(1472, 1280), Vector2(1536, 1280), Vector2(1600, 1280), Vector2(1664, 1280), Vector2(1728, 1280), Vector2(1792, 1280), Vector2(1856, 1280), Vector2(1920, 1280), Vector2(1984, 1280), Vector2(0, 1344), Vector2(64, 1344), Vector2(128, 1344), Vector2(192, 1344), Vector2(256, 1344), Vector2(320, 1344), Vector2(384, 1344), Vector2(448, 1344), Vector2(512, 1344), Vector2(576, 1344), Vector2(640, 1344), Vector2(704, 1344), Vector2(768, 1344), Vector2(832, 1344), Vector2(896, 1344), Vector2(960, 1344), Vector2(1024, 1344), Vector2(1088, 1344), Vector2(1152, 1344), Vector2(1216, 1344), Vector2(1280, 1344), Vector2(1344, 1344), Vector2(1408, 1344), Vector2(1472, 1344), Vector2(1536, 1344), Vector2(1600, 1344), Vector2(1664, 1344), Vector2(1728, 1344), Vector2(1792, 1344), Vector2(1856, 1344), Vector2(1920, 1344), Vector2(1984, 1344), Vector2(0, 1408), Vector2(64, 1408), Vector2(128, 1408), Vector2(192, 1408), Vector2(256, 1408), Vector2(320, 1408), Vector2(384, 1408), Vector2(448, 1408), Vector2(512, 1408), Vector2(576, 1408), Vector2(640, 1408), Vector2(704, 1408), Vector2(768, 1408), Vector2(832, 1408), Vector2(896, 1408), Vector2(960, 1408), Vector2(1024, 1408), Vector2(1088, 1408), Vector2(1152, 1408), Vector2(1216, 1408), Vector2(1280, 1408), Vector2(1344, 1408), Vector2(1408, 1408), Vector2(1472, 1408), Vector2(1536, 1408), Vector2(1600, 1408), Vector2(1664, 1408), Vector2(1728, 1408), Vector2(1792, 1408), Vector2(1856, 1408), Vector2(1920, 1408), Vector2(1984, 1408), Vector2(0, 1472), Vector2(64, 1472), Vector2(128, 1472), Vector2(192, 1472), Vector2(256, 1472), Vector2(320, 1472), Vector2(384, 1472), Vector2(448, 1472), Vector2(512, 1472), Vector2(576, 1472), Vector2(640, 1472), Vector2(704, 1472), Vector2(768, 1472), Vector2(832, 1472), Vector2(896, 1472), Vector2(960, 1472), Vector2(1024, 1472), Vector2(1088, 1472), Vector2(1152, 1472), Vector2(1216, 1472), Vector2(1280, 1472), Vector2(1344, 1472), Vector2(1408, 1472), Vector2(1472, 1472), Vector2(1536, 1472), Vector2(1600, 1472), Vector2(1664, 1472), Vector2(1728, 1472), Vector2(1792, 1472), Vector2(1856, 1472), Vector2(1920, 1472), Vector2(1984, 1472)]
var random_positions := []


func spawn(parent_projectile_node: Node, projectile_scene: PackedScene = pillar_projectile_scene, projectile_count := 100) -> void:
	var global_tile_positions_default_map_copy := global_tile_positions_default_map.duplicate(true)
	# Create a grid of explosions on the floor
	for i in projectile_count:
		var random_index: int = Utils.get_random_int(0, global_tile_positions_default_map_copy.size() - 1)
		var random_position: Vector2 = global_tile_positions_default_map_copy.pop_at(random_index)
		random_positions.push_back(random_position)

	# Instance the explosion scene
	for random_position in random_positions:
		var new_projectile: Node2D = projectile_scene.instance()
		new_projectile.global_position = random_position
		parent_projectile_node.add_child(new_projectile)

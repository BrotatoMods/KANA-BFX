extends "res://main.gd"


const KANA_BFX_LOG_NAME_MAIN := "KANA-BFX:Main"

var KANA_timespan_timer : Node
var KANA_is_wave_over := false
var KANA_spawn_projectile_in_front_of_player_queue := []

onready var KANA_projectiles_parent := $Projectiles
onready var KANA_bfx := get_node("/root/ModLoader/KANA-BFX")


func _ready() -> void:
	# Walking turrets debug points
	if KANA_bfx.settings.walking_turrets.show_debug_points:
		KANA_bfx.KANA_debug_points = Node.new()
		KANA_bfx.walking_turrets_debug_points.name = "KANADebugPoints"
		add_child(KANA_bfx.walking_turrets_debug_points, true)

	KANA_add_timespan_timer()

	if not RunData.effects["kana_bfx_spawn_consumable_random_position"].empty():
		for consumabel_to_spawn in RunData.effects["kana_bfx_spawn_consumable_random_position"]:
			var key: String = consumabel_to_spawn[0]
			var value: int = consumabel_to_spawn[1]
			if not KANA_bfx.state.spawn_consumable.has(key):
				KANA_bfx.state.spawn_consumable[key] = {}
			KANA_bfx.state.spawn_consumable[key].last = KANA_spawn_consumable(key, KANA_get_random_position_in_zone())

	_player.connect("KANA_player_border_collided", self, "_KANA_on_player_border_collided")
	_player.connect("KANA_last_position_updated", self, "_KANA_on_last_position_updated")
	_player.connect("KANA_forward_point_updated", self, "_KANA_on_forward_point_updated")
	KANA_timespan_timer.connect("timeout", self, "_KANA_on_timespan_timer_timeout")
	_entity_spawner.connect("structure_spawned", self, "_KANA_on_structure_spawned")
	_wave_timer.connect("timeout", self, "_KANA_on_wave_timer_timeout")
	KANA_bfx.connect("consumable_spawn_triggered", self, "KANA_spawn_consumable")

	# Clear walking turrets array on wave start
	KANA_bfx.state.walking_turrets.turrets.clear()


func KANA_draw_debug_points() -> void:
	# Remove all points
	for child in KANA_bfx.walking_turrets_debug_points.get_children():
		KANA_bfx.walking_turrets_debug_points.remove_child(child)
		child.queue_free()

	# Add all points ¯\_ツ)_/¯
	for position in _player.KANA_last_positions:
		var new_debug_point : Node2D = KANA_bfx.walking_turrets_debug_point.instance()
		KANA_bfx.walking_turrets_debug_points.add_child(new_debug_point)
		new_debug_point.global_position = position


func KANA_add_timespan_timer() -> void:
	KANA_timespan_timer = preload("res://mods-unpacked/KANA-BFX/content/time_span_timer/time_span_timer.tscn").instance()
	.add_child(KANA_timespan_timer)


func KANA_get_random_position_in_zone(offset := 50) -> Vector2:
	var random_pos := Vector2(
			rand_range(ZoneService.current_zone_min_position.x + offset, ZoneService.current_zone_max_position.x - offset),
			rand_range(ZoneService.current_zone_min_position.y + offset, ZoneService.current_zone_max_position.y - offset)
		)

	return random_pos


# consumable_to_spawn is the my_id of the consumable
func KANA_spawn_consumable(consumable_to_spawn: String, pos: Vector2) -> Node:
	# Get consumable data
	var consumable_data: ConsumableData
	var KANA_dist := rand_range(50, 100)
	var KANA_consumable: Consumable

	if consumable_to_spawn == "consumable_item_box":
		consumable_data = ItemService.item_box
	elif consumable_to_spawn == "consumable_legendary_item_box":
		consumable_data = ItemService.legendary_item_box
	else:
		consumable_data = ItemService.get_element(ItemService.consumables, consumable_to_spawn)

#	Can't use a global class here, it is not registered when this script is parsed.
#	This results in a parse error, breaking the entire extension.
#	if consumable_data is KANABFXConsumableData:
	if not consumable_data.get("consumable_scene") == null:
		KANA_consumable = consumable_data.consumable_scene.instance()
	else:
		KANA_consumable = consumable_scene.instance()

	KANA_consumable.consumable_data = consumable_data
	KANA_consumable.global_position = pos
	_consumables_container.call_deferred("add_child", KANA_consumable)
	KANA_consumable.call_deferred("set_texture", consumable_data.icon)
	var _error := KANA_consumable.connect("picked_up", self, "on_consumable_picked_up")
	KANA_consumable.push_back_destination = Vector2(rand_range(pos.x - KANA_dist, pos.x + KANA_dist), rand_range(pos.y - KANA_dist, pos.y + KANA_dist))
	_consumables.push_back(KANA_consumable)

	return KANA_consumable


func KANA_spawn_enemy(position: Vector2, type: int, scene: PackedScene, data: Resource = null) -> void:
	var pos = _entity_spawner.get_spawn_pos_in_area(position, 200)
	_entity_spawner.queue_to_spawn.push_back([type, scene, pos, data])


func KANA_spawn_projectile(position: Vector2, scene: PackedScene) -> void:
	var new_projectile: Node2D = scene.instance()
	new_projectile.global_position = position
	KANA_projectiles_parent.add_child(new_projectile)


func _KANA_on_forward_point_updated(forward_point: Vector2) -> void:
	for effect_projectile in KANA_spawn_projectile_in_front_of_player_queue:
		KANA_spawn_projectile(forward_point, effect_projectile.projectile_scene)
		effect_projectile.unapply()


func _KANA_on_last_position_updated(last_position: Vector2) -> void:
	for i in KANA_bfx.state.walking_turrets.turrets.size():
		var turret: Node = KANA_bfx.state.walking_turrets.turrets[i]
		# Check if there are enough "last position"
		if i in range(_player.KANA_last_positions.size()):
			# If so tween the global position of the turret to the last position index
			turret.KANA_tween_global_position(_player.KANA_last_positions[i])

	if KANA_bfx.settings.walking_turrets.show_debug_points:
		KANA_draw_debug_points()


func _KANA_on_structure_spawned(structure: Structure) -> void:
	if structure is Turret:
		# Need to use `push_front` here so new turrets move to the end and not the front.
		# Not ideal, but the array is not that large. Perhaps there's a better solution.
		if not structure.KANA_is_excluded_from_walking:
			KANA_bfx.state.walking_turrets.turrets.push_front(structure)
			_player.KANA_update_last_positions_length()


func _KANA_on_wave_timer_timeout() -> void:
	KANA_is_wave_over = true

	if not RunData.effects["kana_bfx_clear_consumable_on_wave_end"].empty():
		for consumable in RunData.effects["kana_bfx_clear_consumable_on_wave_end"]:
			var key: String = consumable[0]
			var value: int = consumable[1]

			if KANA_bfx.state.spawn_consumable[key].last:
				_consumables.erase(KANA_bfx.state.spawn_consumable[key].last)
				KANA_bfx.state.spawn_consumable[key].last.free()


func _KANA_on_temp_stat_timer_timeout(key: String, value: int, seconds: int) -> void:
	if KANA_is_wave_over:
		ModLoaderLog.debug("temp_stat_timer_timeout - Did not remove stat, wave is over.", KANA_BFX_LOG_NAME_MAIN)
		return
	TempStats.remove_stat(key, value)
	ModLoaderLog.debug("Removed stat -> %s new value is -> %s" % [key, str(TempStats.get_stat(key))], KANA_BFX_LOG_NAME_MAIN)


func _KANA_on_timespan_timer_timeout(key: String, value: int, seconds: int) -> void:
	if KANA_is_wave_over:
		ModLoaderLog.debug("timespan_timer_timeout - Did not remove effect, wave is over.", KANA_BFX_LOG_NAME_MAIN)
		return
	RunData.effects[key] = RunData.effects[key] - value
	ModLoaderLog.debug("Removed effect, new value of %s is -> %s" % [key, str(RunData.effects[key])], KANA_BFX_LOG_NAME_MAIN)


func KANA_get_opposite_collision_tile_position(position: Vector2, direction: Vector2) -> Vector2:
	var current_zone = ZoneService.get_zone_data(RunData.current_zone).duplicate()
	var opposite_position: Vector2
	var spawn_offset = 1 * 64

	if direction == Vector2(1, 0):
		opposite_position = Vector2((current_zone.width * 64) - spawn_offset, position.y)
	elif direction == Vector2(-1, 0):
		opposite_position = Vector2(spawn_offset, position.y)
	elif direction == Vector2(0, 1):
		opposite_position = Vector2(position.x, (current_zone.height * 64) - spawn_offset)
	elif direction == Vector2(0, -1):
		opposite_position = Vector2(position.x, spawn_offset)

	return opposite_position


func _KANA_on_player_border_collided(collision: KinematicCollision2D) -> void:
	if RunData.effects["kana_bfx_port_to_opposite_side"]:
		var tile_position_player: Vector2 = collision.collider.world_to_map(_player.position)
		var tile_position_collider: Vector2 = tile_position_player - collision.normal

		var opposite_position := KANA_get_opposite_collision_tile_position(collision.position, collision.normal)

		_player.global_position = opposite_position


func KANA_create_temp_effect_timer(key: String, value: int, seconds: int) -> void:
	ModLoaderLog.debug("Adding effect -> %s with value -> %s" % [key, value], KANA_BFX_LOG_NAME_MAIN)
	ModLoaderLog.debug("Current effect value of -> %s is -> %s" % [key, str(RunData.effects[key])], KANA_BFX_LOG_NAME_MAIN)
	KANA_timespan_timer.KANA_create_temp_timer(key, value, seconds)


func KANA_create_temp_stat_timer(key: String, value: int, seconds: int) -> void:
	TempStats.add_stat(key, value)
	ModLoaderLog.debug("Added stat -> %s with value -> %s" % [key, value], KANA_BFX_LOG_NAME_MAIN)
	ModLoaderLog.debug("Current stat value of -> %s is -> %s" % [key, str(TempStats.get_stat(key))], KANA_BFX_LOG_NAME_MAIN)
	var timer := KANA_add_timer(seconds)
	timer.connect("timeout", self, "_KANA_on_temp_stat_timer_timeout", [key, value, seconds])


func KANA_add_timer(seconds: int, is_one_shot := true) -> Timer:
	var new_timer: Timer = Timer.new()
	new_timer.one_shot = is_one_shot
	add_child(new_timer)
	new_timer.start(seconds)

	return new_timer


func on_consumable_picked_up(consumable: Node) -> void:
	.on_consumable_picked_up(consumable)

	for effect in RunData.effects["kana_bfx_add_random_effect_on_consumable_collected"]:
		effect.apply_random_effect()

	if not RunData.effects["kana_bfx_temp_effect_for_time_amount"].empty():
		var temp_effect := RunData.effects["kana_bfx_temp_effect_for_time_amount"].pop_back() as Array
		KANA_create_temp_effect_timer(temp_effect[0], temp_effect[1], temp_effect[2])

	if not RunData.effects["kana_bfx_temp_stat_for_time_amount"].empty():
		var temp_stat := RunData.effects["kana_bfx_temp_stat_for_time_amount"].pop_back() as Array
		KANA_create_temp_stat_timer(temp_stat[0], temp_stat[1], temp_stat[2])

	for consumabel_to_spawn in RunData.effects["kana_bfx_spawn_consumable_random_position"]:
		var key: String = consumabel_to_spawn[0]
		var value: int = consumabel_to_spawn[1]
		if consumable.consumable_data.my_id == key:
			if not KANA_bfx.state.spawn_consumable.has(key):
				KANA_bfx.state.spawn_consumable[key] = {}
			KANA_bfx.state.spawn_consumable[key].last = KANA_spawn_consumable(key, KANA_get_random_position_in_zone())

	for turret_to_spawn in RunData.effects["kana_bfx_consumable_turrets"]:
		var key: String = turret_to_spawn[0]
		var value: int = turret_to_spawn[1]
		if consumable.consumable_data.my_id == key:
			for i in range(value):
				var pos = _entity_spawner.get_spawn_pos_in_area(consumable.global_position, 200)
				_entity_spawner.queue_to_spawn_structures.push_back([EntityType.STRUCTURE, turret_effect.scene, pos, turret_effect])

	# If a crate got collected
	if consumable.consumable_data.my_id == "consumable_item_box":
		# Check if the stat on crate collected effect is active
		for effect in RunData.effects["kana_bfx_gain_stat_for_item_box_collected"]:
			RunData.add_stat(effect[0], effect[1])

		for effect in RunData.effects["kana_bfx_gain_temp_stat_for_item_box_collected"]:
			TempStats.add_stat(effect[0], effect[1])

	for effect in RunData.effects["kana_bfx_spawn_enemy_on_consumable_collected"]:
		if consumable.consumable_data.my_id == effect.key:
			KANA_spawn_enemy(consumable.global_position, EntityType.ENEMY, effect.enemy_scene)

	for effect in RunData.effects["kana_bfx_spawn_projectile_grid_on_consumable_collected"]:
		if consumable.consumable_data.my_id == effect.key:
			var projectile_grid_spawner: KANAProjectileGridSpawner = preload("res://mods-unpacked/KANA-BFX/content/scripts/projectile_grid_spawner.gd").new()
			projectile_grid_spawner.spawn(KANA_projectiles_parent, effect.projectile_scene, effect.projectile_count)
			projectile_grid_spawner.free()

	for effect in RunData.effects["kana_bfx_spawn_projectile_in_front_of_player_on_consumable_collected"]:
		if consumable.consumable_data.my_id == effect.key:
			KANA_spawn_projectile_in_front_of_player_queue.push_back(effect)

	for effect in RunData.effects["kana_bfx_remove_effect_after_consumable_collected"]:
		var key: String = effect[0]
		var value: int = effect[1]
		var effects_to_remove: Array = effect[2]

		if consumable.consumable_data.my_id == key:
			for effect_to_remove in effects_to_remove:
				effect_to_remove.unapply()


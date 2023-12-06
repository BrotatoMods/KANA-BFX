extends Area2D


var collider_depth = 4.0 * Utils.TILE_SIZE
var offset = 20


func init(zone:ZoneData)->void :
	var width = zone.width * Utils.TILE_SIZE
	var height = zone.height * Utils.TILE_SIZE

	# Top
	create_wall(
		Vector2(width / 2, - collider_depth / 2), Vector2(width + collider_depth, collider_depth + offset)
	)
	# Right
	create_wall(
		Vector2((width + collider_depth / 2) - offset, height / 2),
		Vector2(collider_depth, height + collider_depth)
	)
	# Bottom
	create_wall(
		Vector2(width / 2, height + collider_depth / 2),
		Vector2(width + collider_depth, collider_depth + offset)
	)
	# Left
	create_wall(
		Vector2( - (collider_depth / 2) + offset, height / 2), Vector2(collider_depth, height + collider_depth)
	)


func create_wall(center:Vector2, size:Vector2)->void :
	var wall_shape = CollisionShape2D.new()
	wall_shape.shape = RectangleShape2D.new()
	wall_shape.shape.extents = size / 2
	self.add_child(wall_shape)
	wall_shape.global_position = center

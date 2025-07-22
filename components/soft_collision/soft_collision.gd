extends Area2D

func is_colliding() -> int:
	var areas = get_overlapping_areas()
	return areas.size()

func get_push_vector():
	var areas = get_overlapping_areas()
	if areas.size():
		var area = areas[0]
		return area.global_position.direction_to(global_position).normalized()

	return Vector2.ZERO

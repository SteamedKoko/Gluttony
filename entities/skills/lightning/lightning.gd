class_name Lightning
extends BaseSkill

@export var area_around_player: Vector2 = Vector2(300,300)
@export var min_area_around_player: Vector2 = Vector2(20,20)

var refresh_spawnpoint: bool = true
var direction: Array = [-1, 1]

var spawn_point: Vector2
var spawn_direction: int


func get_new_spawnpoint():
	var new_point: Vector2 = Vector2.ZERO
	new_point.x = randf_range(min_area_around_player.x, area_around_player.x)
	new_point.y = randf_range(min_area_around_player.y, area_around_player.y)
	spawn_point = new_point
	spawn_direction = direction.pick_random()

func _physics_process(_delta: float) -> void:
	if !animated_sprite.visible:
		global_position = GameManager.player.global_position + (spawn_point * spawn_direction)
		if refresh_spawnpoint:
			get_new_spawnpoint()
			refresh_spawnpoint = false
			
	else:
		refresh_spawnpoint = true

class_name Fire
extends BaseSkill

@export var fire_size = Vector2(5,5)

@onready var flame_position: Node2D = GameManager.player.get_node("FirePosition")

var flip_vector = Vector2(-1,1)

func _physics_process(delta: float) -> void:
	global_position = flame_position.global_position
	if flame_position.global_scale.y < 0:
		scale = fire_size
	else:
		scale = (fire_size * flip_vector)

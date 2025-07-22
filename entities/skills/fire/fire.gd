class_name Fire
extends BaseSkill

@export var base_fire_size = Vector2(1,1)

@onready var flame_position: Node2D = GameManager.player.get_node("FirePosition")

var fire_size: Vector2 :
	get:
		return base_fire_size * level * size_multiplyer

var flip_vector = Vector2(-1,1)
var size_multiplyer: float = 1.5

func _ready() -> void:
	damage_multiplyer = 2
	super._ready()


func _physics_process(delta: float) -> void:
	global_position = flame_position.global_position
	if flame_position.global_scale.y < 0:
		scale = fire_size
	else:
		scale = (fire_size * flip_vector)

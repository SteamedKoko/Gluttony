class_name SharpThingy
extends Attack

var base_damage: int = 0

var rotation_speed = 90.0 
var sprite_resource: Resource 
var current_angle = 0.0
var radius = 50.0

func _ready() -> void:
	var sprite: Sprite2D = $Sprite2D
	sprite.texture = sprite_resource

func _physics_process(delta: float) -> void:
	current_angle += deg_to_rad(rotation_speed) * delta
	position = GameManager.player.global_position + (Vector2(cos(current_angle), sin(current_angle)) * radius)

	super._physics_process(delta)

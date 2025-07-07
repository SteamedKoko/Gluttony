class_name BaseMonster
extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var soft_collision = $SoftCollision

@export var push_strength = 800
@export var move_speed: float = 100
@export var acceleration: float = 300

var _exp_value: float = 10

func _physics_process(_delta: float) -> void:
	move_monster(_delta)
	

func move_monster(delta) -> void:
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = velocity.move_toward(direction * move_speed, acceleration * delta)

	if soft_collision.is_colliding():
		velocity += soft_collision.get_push_vector() * delta * push_strength

	velocity.x = clamp(velocity.x, -move_speed, move_speed)
	velocity.y = clamp(velocity.y, -move_speed, move_speed)
	move_and_slide()


func perish() -> void:
	player.current_exp += _exp_value
	queue_free()

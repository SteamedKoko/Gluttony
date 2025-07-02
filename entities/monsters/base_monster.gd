class_name BaseMonster
extends CharacterBody2D

@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var soft_collision = $SoftCollision

var move_speed: float = 100
var acceleration: float = 100

var _exp_value: float = 1
var _damage: float = 1

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	move_monster(_delta)
	
func move_monster(delta) -> void:
	var direction = (player.global_position - global_position).normalized()
	velocity = velocity.move_toward(direction * move_speed, acceleration * delta)

	if soft_collision.is_colliding():
		velocity += soft_collision.get_push_vector() * delta * 200

	velocity.x = clamp(velocity.x, -move_speed, move_speed)
	velocity.y = clamp(velocity.y, -move_speed, move_speed)
	move_and_slide()

			
func player_collision_action(body: Node2D) -> void:
	body.eat_food(_exp_value, _damage)
	perish()

func perish() -> void:
	queue_free()

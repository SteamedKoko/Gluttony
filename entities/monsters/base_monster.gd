class_name BaseMonster
extends CharacterBody2D

var default_scale: float = 1 * GameManager.skill_manager.monster_scale_multiplyer
var move_speed: float = 100 * GameManager.skill_manager.monster_speed_multiplyer

@export var push_strength = 800
@export var acceleration: float = 300
@export var _exp_value: float = 10

@onready var soft_collision = $SoftCollision
@onready var health: Health = $Health

var move_speed_mult: float = 2

func _ready() -> void:
	var new_hp: int = health.max_health + ceil(float(GameManager.player.current_level) / 5)
	health.health = new_hp
	health.max_health = new_hp
	health.health_depleted.connect(perish)
	scale =  default_scale * Vector2.ONE


func _physics_process(_delta: float) -> void:
	move_monster(_delta)
	

func move_monster(delta) -> void:
	if GameManager.player:
		var direction = (GameManager.player.global_position - global_position).normalized()
		velocity = velocity.move_toward(direction * move_speed, acceleration * delta)

	# if soft_collision and soft_collision.is_colliding():
	# 	velocity += soft_collision.get_push_vector() * delta * push_strength

	velocity.x = clamp(velocity.x, -move_speed * move_speed_mult, move_speed * move_speed_mult)
	velocity.y = clamp(velocity.y, -move_speed * move_speed_mult, move_speed * move_speed_mult)
	move_and_slide()


func perish() -> void:
	var exp_to_add = _exp_value * ceil(float(GameManager.player.current_level) / 5)
	GameManager.player.add_exp(exp_to_add)
	queue_free()


func remove() -> void:
	queue_free()

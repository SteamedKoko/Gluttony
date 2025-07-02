class_name Player
extends CharacterBody2D

@export var speed: float = 250
@export var max_hp: float = 100
@export var damage_modifier: float = 1

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var current_exp: float = 0
var current_level: float = 0
var current_hp: float = 100

var is_facing_left: bool = true

func get_movement():
	var input = Input.get_vector("left", "right", "up", "down")
	velocity = input * speed;
	set_orientation()

func set_orientation():
	if velocity.x > 0 and is_facing_left:
		scale.x = -1
		is_facing_left = false
	if velocity.x < 0 and !is_facing_left:
		scale.x = -1
		is_facing_left = true


func eat_food(exp_gained: float, damage: float):
	# queue nom sound
	current_hp -= damage
	current_exp += exp_gained

func _physics_process(_delta: float) -> void:
	get_movement()
	move_and_slide()

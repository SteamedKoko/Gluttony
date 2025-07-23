class_name Player
extends CharacterBody2D

@export var speed: float = 250
@export var damage_modifier: float = 1
@export var max_health_lost_per_level: int = 10

@export var exp_per_level: float = 10
@export var exp_scaling: float = 3


@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var health: Health = $Health
@onready var hurt_box: HurtBox = $HurtBox

enum state {
	DASH,
	CHILLIN
}

var player_state: state = state.CHILLIN

signal leveled_up

var current_exp: float:
	set(val):
		current_exp = val
		if current_exp > next_level_experience:
			level_up()

var current_level: int = 0
var next_level_experience: float = 10

var is_facing_left: bool = true

func _ready():
	pass

func level_up():
	while current_exp >= next_level_experience:
		current_level+=1
		next_level_experience += pow(current_level, exp_scaling) + exp_per_level
		leveled_up.emit()
		health.take_max_health(max_health_lost_per_level)
	


func get_movement():
	if player_state == state.CHILLIN:
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

func add_exp(exp_to_add: float):
	current_exp += exp_to_add

func _physics_process(_delta: float) -> void:
	get_movement()
	move_and_slide()


func _on_health_health_delpleted() -> void:
	pass
	# queue_free()

class_name Player
extends CharacterBody2D

@export var speed: float = 250
@export var damage_modifier: float = 1
@export var max_health_lost_per_level: int = 5

@export var exp_per_level: int = 10
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
signal gained_exp

var current_exp: int:
	set(val):
		current_exp = val
		gained_exp.emit()
		if current_exp >= next_level_experience:
			level_up()

var current_level: int = 1
var next_level_experience: int = 10

var is_facing_left: bool = true

func _ready():
	# health.health = 1
	health.health_depleted.connect(_on_health_health_delpleted)
	# for i in range(10):
	# 	GlobalSkillManager.add_skill(GlobalSkillManager.skills.FIRE)
	pass
	
func level_up():
	current_exp -= next_level_experience
	current_level += 1
	next_level_experience = floor(pow(current_level, exp_scaling)) + exp_per_level
	leveled_up.emit()
	health.take_max_health(max_health_lost_per_level)


func debuff_speed(amount_to_mult: float = .8):
	speed *= amount_to_mult

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
	print('depleted')
	GameManager.game_over()

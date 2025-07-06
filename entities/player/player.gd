class_name Player
extends CharacterBody2D

@export var speed: float = 250
@export var max_hp: float = 100
@export var damage_modifier: float = 1
@export var max_health_lost_per_level: float = 10

@export var exp_per_level: float = 10
@export var exp_scaling: float = 3

@export var dash_timer_seconds: float = .2
@export var dash_velocity: float = 800
@export var dash_cooldown_seconds: float = 10

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var health: Health = $Health
@onready var dash_cooldown_timer: Timer = $DashCooldownTimer

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

var current_level: float = 0
var next_level_experience: float = 10

var is_facing_left: bool = true

func level_up():
	while current_exp >= next_level_experience:
		current_level+=1
		next_level_experience += pow(current_level, exp_scaling) + exp_per_level
		print('current level ', current_level, ',current exp ', current_exp, ', next level ', next_level_experience)
		leveled_up.emit()
		health.take_max_health(max_health_lost_per_level)
	

func get_dash():
	var dash_pressed = Input.is_action_pressed("dash")
	if player_state == state.CHILLIN and dash_pressed and dash_cooldown_timer.is_stopped():
		player_state = state.DASH
		var direction = Input.get_vector("left", "right", "up", "down").normalized()
		print(player_state)
		print('dash')
		velocity = direction * dash_velocity
		dash_cooldown_timer.start()
		await get_tree().create_timer(dash_timer_seconds).timeout
		player_state = state.CHILLIN
		print(player_state)

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
	get_dash()
	get_movement()
	move_and_slide()


func _on_health_health_delpleted() -> void:
	print('you ded')
	# queue_free()


func _on_hurt_box_took_damage() -> void:
	pass

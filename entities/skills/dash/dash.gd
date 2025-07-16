extends Node2D

@export var dash_timer_seconds: float = .2
@export var dash_velocity: float = 800
@export var dash_cooldown_seconds: float = 10

@onready var dash_cooldown_timer: Timer = $DashCooldownTimer

var player: Player = GameManager.player

func get_dash():
	var dash_pressed = Input.is_action_pressed("dash")
	if player.player_state == player.state.CHILLIN and dash_pressed and dash_cooldown_timer.is_stopped():
		player.player_state = player.state.DASH
		var direction = Input.get_vector("left", "right", "up", "down").normalized()
		player.velocity = direction * dash_velocity
		dash_cooldown_timer.start()
		await get_tree().create_timer(dash_timer_seconds).timeout
		player.player_state = player.state.CHILLIN

func _physics_process(_delta: float) -> void:
	get_dash()

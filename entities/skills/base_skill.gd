class_name BaseSkill
extends Node2D

@export var time_to_cast: float = 0
@export var frame_to_enable_collider: int = 0
@export var frame_to_end_collider: int = 0
@export var damage: int
@export var damage_cooldown: float
@export var knockback: float

var animated_sprite: AnimatedSprite2D
var execute_timer: Timer
var attack: Attack

var level: int = 1 :
	set(value):
		if(attack):
			attack.damage = damage * (level * damage_multiplyer)
		level = value

var damage_multiplyer: float = 1

func _ready() -> void:
	execute_timer = Timer.new()
	execute_timer.timeout.connect(_on_execute_timeout)
	execute_timer.wait_time = time_to_cast
	execute_timer.autostart = true
	self.add_child(execute_timer)

	animated_sprite = $AnimatedSprite2D
	animated_sprite.visible = false
	animated_sprite.frame_changed.connect(_on_animated_sprite_changed)
	animated_sprite.animation_finished.connect(_on_animated_sprite_finished)

	attack = $Attack
	attack.damage = damage
	attack.damage_cooldown = damage_cooldown
	attack.monitoring = false
	attack.knockback = knockback


func _on_execute_timeout() -> void:
	animated_sprite.play()
	animated_sprite.visible = true


func _on_animated_sprite_changed() -> void:
	if animated_sprite.frame == frame_to_enable_collider:
		attack.monitoring = true 

	if animated_sprite.frame == frame_to_end_collider:
		attack.monitoring = false 


func _on_animated_sprite_finished() -> void:
	attack.monitoring = false 
	animated_sprite.visible = false

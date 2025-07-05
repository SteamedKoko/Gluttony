class_name HurtBox
extends Area2D

@export var health: Health
@export var invulerability_time_seconds: float = .5

signal took_damage

func receive_damage(damage: float):
	if monitoring:
		iframes()
		health.take_health(damage)
		took_damage.emit()


func iframes():
	if monitoring:
		monitoring = false
		await get_tree().create_timer(invulerability_time_seconds).timeout
		monitoring = true

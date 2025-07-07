class_name Health
extends Node

@export var max_health: float

@onready var health: float = max_health

signal health_delpleted()


func take_health(amount_to_decrease: float):
	health = maxf(0, health - amount_to_decrease)
	print(health)
	if health == 0:
		health_delpleted.emit()


func take_max_health(amount_to_decrease: float):
	max_health = maxf(1, max_health - amount_to_decrease)
	if health > max_health:
		health = max_health

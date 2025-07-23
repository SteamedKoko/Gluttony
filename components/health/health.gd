class_name Health
extends Node

@export var max_health: int

@onready var current_max_health: int = max_health
@onready var health: int = max_health

signal health_changed()
signal health_depleted()


func take_health(amount_to_decrease: int):
	health = max(0, health - amount_to_decrease)
	health_changed.emit()
	if health == 0:
		health_depleted.emit()


func take_max_health(amount_to_decrease: int):
	current_max_health = max(1, current_max_health - amount_to_decrease)
	if health > current_max_health:
		health = current_max_health

	health_changed.emit()

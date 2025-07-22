class_name BaseSkill
extends Node2D

@export var base_size: Vector2 = Vector2.ONE
@export var damage_multiplyer: float = 1
@export var knockback_multiplyer: float = 1
@export var size_multiplyer: Vector2 = Vector2.ONE

var level: int = 1
var can_level: bool = true

func level_up() -> void:
	level += 1
	level_up_action()

func level_up_action() -> void:
	pass

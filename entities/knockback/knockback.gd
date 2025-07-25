class_name Knockback
extends Node2D

@onready var parent = get_parent()


func _on_hurt_box_got_knocked_back(knockback: float) -> void:
	var direction = GameManager.player.global_position.direction_to(global_position).normalized()
	parent.velocity += direction * knockback

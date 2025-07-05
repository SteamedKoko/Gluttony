class_name Attack
extends Area2D

@export var damage: float = 50

signal dealt_damage

func _on_area_entered(area:Area2D) -> void:
    if area is HurtBox:
        area.receive_damage(damage)
        dealt_damage.emit()

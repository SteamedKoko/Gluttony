class_name Attack
extends Area2D

@export var damage: float = 0
@export var knockback = 0

signal dealt_damage()

func check_and_apply_damage():
	if not monitoring:
		return

	var overlap = get_overlapping_areas()
	for ob in overlap:
		if(ob is HurtBox):
			if ob.try_receive_damage(damage, knockback):
				dealt_damage.emit()



func _physics_process(_delta: float) -> void:
	check_and_apply_damage()


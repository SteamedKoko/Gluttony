class_name Attack
extends Area2D

@export var damage: float = 0
@export var knockback = 0
@export var damage_cooldown: float = 0

signal dealt_damage()

func check_and_apply_damage():
	if not monitoring:
		return

	var overlap = get_overlapping_areas()
	for ob in overlap:
		if(ob is HurtBox):
			if damage_cooldown > 0:
				if ob.try_receive_continuous_damage(damage, knockback, damage_cooldown, name):
					dealt_damage.emit()
				
			elif ob.try_receive_damage(damage, knockback):
				dealt_damage.emit()



func _physics_process(_delta: float) -> void:
	check_and_apply_damage()


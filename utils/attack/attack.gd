class_name Attack
extends Area2D

enum DAMAGE_TYPE {
	NONE,
	FIRE,
	LIGHTNING
}

@export var damage: float = 50
@export var damage_cooldown: float = 0
@export var damage_type: DAMAGE_TYPE

func _physics_process(_delta: float) -> void:
	var overlap = get_overlapping_areas()
	for ob in overlap:
		if(ob is HurtBox):
			if damage_cooldown == 0:
				ob.receive_damage(damage)
			else:
				ob.receive_continuous_damage(damage, damage_cooldown, str(damage_type))

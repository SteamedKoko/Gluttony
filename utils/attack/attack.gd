class_name Attack
extends Area2D

enum DAMAGE_TYPE {
	NONE,
	FIRE,
	LIGHTNING,
	SHARP_THINGY
}

@export var damage: float = 0
@export var damage_cooldown: float = 0
@export var damage_type: DAMAGE_TYPE
@export var angle_offset: float = 0
@export var knockback = 0

signal dealt_damage()

func check_and_apply_damage():
	if not monitoring:
		return

	var overlap = get_overlapping_areas()
	for ob in overlap:
		if(ob is HurtBox):
			var did_damage = false
			if damage_cooldown == 0:
				did_damage = ob.receive_damage(damage, knockback)
			else:
				did_damage = ob.receive_continuous_damage(damage, knockback, damage_cooldown, str(damage_type))

			if did_damage:
				dealt_damage.emit()



func _physics_process(_delta: float) -> void:
	check_and_apply_damage()


func _on_area_entered(area:Area2D) -> void:
	print('area entered')

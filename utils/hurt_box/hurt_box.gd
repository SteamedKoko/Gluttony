class_name HurtBox
extends Area2D

@export var health: Health
@export var invulerability_time_seconds: float = .5

var damage_source_dictionary: Dictionary

signal took_damage(dmg)
signal got_knocked_back(knockback)

func receive_damage(damage: float, knockback: float) -> bool:
	health.take_health(damage)
	took_damage.emit(damage)

	if knockback > 0:
		got_knocked_back.emit(knockback)

	return true


func receive_continuous_damage(damage: float, knockback: float,dmg_cooldown: float, key: String) -> bool:
	if damage_source_dictionary.has(key):
		return false

	damage_source_dictionary[key] = 0
	var dmg_timer: SceneTreeTimer = get_tree().create_timer(dmg_cooldown)
	dmg_timer.timeout.connect(remove_damage_timeout.bind(key))
	health.take_health(damage)
	took_damage.emit(damage)

	if knockback > 0:
		got_knocked_back.emit(knockback)

	return true


func remove_damage_timeout(key: String):
	damage_source_dictionary.erase(key)


# func iframes():
# 	if monitoring:
# 		monitoring = false
# 		await get_tree().create_timer(invulerability_time_seconds).timeout
# 		monitoring = true

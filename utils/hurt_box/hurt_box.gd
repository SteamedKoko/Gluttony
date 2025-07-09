class_name HurtBox
extends Area2D

@export var health: Health
@export var invulerability_time_seconds: float = .5

var damage_source_dictionary: Dictionary

signal took_damage

func receive_damage(damage: float):
	if monitoring:
		iframes()
		health.take_health(damage)
		took_damage.emit()


func receive_continuous_damage(damage: float, dmg_cooldown: float, key: String):
	if damage_source_dictionary.has(key):
		return

	damage_source_dictionary[key] = 0
	var dmg_timer: SceneTreeTimer = get_tree().create_timer(dmg_cooldown)
	dmg_timer.timeout.connect(remove_damage_timeout.bind(key))
	health.take_health(damage)


func remove_damage_timeout(key: String):
	damage_source_dictionary.erase(key)


func iframes():
	if monitoring:
		monitoring = false
		await get_tree().create_timer(invulerability_time_seconds).timeout
		monitoring = true

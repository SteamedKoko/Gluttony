class_name Fire
extends BaseSkill

@onready var attack: AnimatedAttack = $AnimatedAttack
@onready var flame_position: Node2D = GameManager.player.get_node("FirePosition")

var flip_vector = Vector2(-1,1)
	
func _get_fire_size() -> Vector2:
	return base_size * level * size_multiplyer

func _physics_process(_delta: float) -> void:
	global_position = flame_position.global_position
	var fire_size = _get_fire_size()
	scale = fire_size if flame_position.global_scale.y < 0 else fire_size * flip_vector

func level_up_action() -> void:
	attack.damage = ceil(attack.damage * damage_multiplyer)
	attack.knockback = ceil(attack.knockback * knockback_multiplyer)

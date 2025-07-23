class_name Lightning
extends BaseSkill

@export var area_around_player: Vector2 = Vector2(300,300)
@export var min_area_around_player: Vector2 = Vector2(5,5)

@onready var attack: AnimatedAttack = $AnimatedAttack

var refresh_spawnpoint: bool = true

var spawn_point: Vector2
var spawn_direction: int


func get_new_spawnpoint():
	var new_point: Vector2 = Vector2.ZERO
	new_point.x = randf_range(min_area_around_player.x, area_around_player.x)
	new_point.y = randf_range(min_area_around_player.y, area_around_player.y)
	spawn_point = new_point
	spawn_direction = [-1, 1].pick_random()


func _physics_process(_delta: float) -> void:
	if !attack.animated_sprite.visible:
		global_position = GameManager.player.global_position + (spawn_point * spawn_direction)
		if refresh_spawnpoint:
			get_new_spawnpoint()
			refresh_spawnpoint = false
			
	else:
		refresh_spawnpoint = true


func level_up_action() -> void:
	attack.damage = ceil(attack.damage * damage_multiplyer)
	attack.knockback = ceil(attack.knockback * knockback_multiplyer)
	scale *=  size_multiplyer

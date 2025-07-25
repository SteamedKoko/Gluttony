class_name Spawner
extends Node

@onready var screen_size = get_viewport().get_visible_rect().size


func _spawn_monster(postion: Vector2, sprite_type: GlobalSpriteAssets.MonsterSprites) -> void:
	var new_monster = GlobalSpriteAssets.get_monster_asset(sprite_type)
	new_monster.global_position = postion
	add_child(new_monster)

func _spawn_random_monster(postion: Vector2) -> void:
	var new_monster = GlobalSpriteAssets.get_random_monster_asset()
	new_monster.global_position = postion
	add_child(new_monster)


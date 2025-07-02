extends Node

@onready var screen_size = get_viewport().get_visible_rect().size


func _spawn_monster() -> void:
	var new_monster = GlobalSpriteAssets.get_random_monster_asset()
	add_child(new_monster)

func _on_spawn_timer_timeout() -> void:
	_spawn_monster()

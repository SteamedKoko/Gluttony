class_name BaseMonster
extends Area2D

@export var monster_sprite = GlobalSpriteAssets.MonsterSprites.PIE

@onready var anim: SpriteLoader = $SpriteLoader

func _ready() -> void:
	var res = GlobalSpriteAssets.MONSTER_RESOURCES.get(monster_sprite).resource
	print(res)
	anim.load_sprite(res, 35, 35, 4, 1) 
	anim.play()

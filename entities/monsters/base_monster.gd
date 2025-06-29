class_name BaseMonster
extends Area2D

@export var monster_sprite = GlobalSpriteAssets.MonsterSprites.PIE

@onready var player = get_parent().get_node("Player")


var anim: SpriteLoader
var veclocity: float = 100

func _ready() -> void:
	var res = GlobalSpriteAssets.MONSTER_RESOURCES.get(monster_sprite).resource
	print(res)
	anim = SpriteLoader.new()
	self.add_child(anim)
	anim.load_sprite(res, 35, 35, 4, 1) 

	anim.play()

func _physics_process(_delta: float) -> void:
	if(player):
		self.position = self.position.move_toward(player.position, _delta * veclocity)
	

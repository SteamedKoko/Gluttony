class_name BaseMonster
extends CharacterBody2D

@export var monster_sprite = GlobalSpriteAssets.MonsterSprites.PIE

@onready var player = get_tree().get_nodes_in_group("player")[0]


var anim: SpriteLoader
var veclocity: float = 100

var exp_value: float = 1
var damage: float = 1

func _init(sprite: GlobalSpriteAssets.MonsterSprites):
	monster_sprite = sprite

func _ready() -> void:
	var res = GlobalSpriteAssets.MONSTER_RESOURCES.get(monster_sprite).resource
	anim = SpriteLoader.new()
	self.add_child(anim)
	anim.load_sprite(res, 35, 35, 4, 1) 

	anim.play()

func _physics_process(_delta: float) -> void:
	pass
	

func _on_body_entered(body:Node2D) -> void:
	if body is Player:
		body.eat_food(exp_value, damage)
		perish()

func perish() -> void:
	queue_free()

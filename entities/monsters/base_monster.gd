class_name BaseMonster
extends Area2D

@export var monster_sprite = GlobalSpriteAssets.MonsterSprites.PIE

@onready var player = get_parent().get_node("Player")


var anim: SpriteLoader
var veclocity: float = 100

var exp: float = 1
var damage: float = 1

func _ready() -> void:
	var res = GlobalSpriteAssets.MONSTER_RESOURCES.get(monster_sprite).resource
	anim = SpriteLoader.new()
	self.add_child(anim)
	anim.load_sprite(res, 35, 35, 4, 1) 

	anim.play()

func _physics_process(_delta: float) -> void:
	if(player):
		self.position = self.position.move_toward(player.position, _delta * veclocity)
	

func _on_body_entered(body:Node2D) -> void:
	if body is Player:
		body.eat_food(exp, damage)
		perish()

func perish() -> void:
	queue_free()

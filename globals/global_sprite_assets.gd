class_name GlobalSpriteAssets
extends Node

const MONSTER_SCENE: PackedScene = preload("res://entities/monsters/BaseMonster.tscn")

const DEFAULT_MONSTER_WIDTH: int = 35
const DEFAULT_MONSTER_HEIGHT: int = 35
const DEFAULT_MONSTER_FRAMES: int = 4
const DEFAULT_MONSTER_ROW: int = 1

static func get_random_monster_asset() -> BaseMonster:
	var randomMonsterString = GlobalSpriteAssets.MonsterSprites.keys()[randi() % GlobalSpriteAssets.MonsterSprites.size()]
	var sprite = MonsterSprites.get(randomMonsterString)	
	return get_monster_asset(sprite)

static func get_monster_asset(sprite: MonsterSprites) -> BaseMonster:
	var monster_asset: Dictionary = MONSTER_RESOURCES.get(sprite)
	monster_asset.get_or_add("width", DEFAULT_MONSTER_WIDTH)
	monster_asset.get_or_add("height", DEFAULT_MONSTER_HEIGHT)
	monster_asset.get_or_add("frames", DEFAULT_MONSTER_FRAMES)
	monster_asset.get_or_add("row", DEFAULT_MONSTER_ROW)
	
	var new_monster: BaseMonster = MONSTER_SCENE.instantiate()

	var _sprite_loader = SpriteLoader.new()
	_sprite_loader.load_sprite(monster_asset.resource, monster_asset.width, monster_asset.height, monster_asset.frames, monster_asset.row) 

	new_monster.add_child(_sprite_loader)

	return new_monster

static var MONSTER_RESOURCES: Dictionary = {
	MonsterSprites.AVOCADO : { "resource" = preload("res://entities/monsters/sprites/avocado.png") },
	MonsterSprites.BOBA: { "resource" = preload("res://entities/monsters/sprites/boba.png") },
	MonsterSprites.BREAD: { "resource" = preload("res://entities/monsters/sprites/bread.png") },
	MonsterSprites.CARROT_CAKE: { "resource" = preload("res://entities/monsters/sprites/carrot cake.png") },
	MonsterSprites.COFFEE: { "resource" = preload("res://entities/monsters/sprites/coffee.png") },
	MonsterSprites.CORNDOG: { "resource" = preload("res://entities/monsters/sprites/corndog.png") },
	MonsterSprites.DONUT: { "resource" = preload("res://entities/monsters/sprites/donut.png") },
	MonsterSprites.HOTDOG: { "resource" = preload("res://entities/monsters/sprites/hotdog.png") },
	MonsterSprites.JELLY: { "resource" = preload("res://entities/monsters/sprites/jelly.png") },
	MonsterSprites.JUICE: { "resource" = preload("res://entities/monsters/sprites/juice.png") },
	MonsterSprites.KETCHUP: { "resource" = preload("res://entities/monsters/sprites/ketchup.png") },
	MonsterSprites.KISS: { "resource" = preload("res://entities/monsters/sprites/kiss.png") },
	MonsterSprites.MARSHMALLOW: { "resource" = preload("res://entities/monsters/sprites/marshmallow.png") },
	MonsterSprites.MUSTARD: { "resource" = preload("res://entities/monsters/sprites/mustard.png") },
	MonsterSprites.NASILEMAK: { "resource" = preload("res://entities/monsters/sprites/nasilemak.png") },
	MonsterSprites.ONIGIRI: { "resource" = preload("res://entities/monsters/sprites/onigiri.png") },
	MonsterSprites.PIE: { "resource" = preload("res://entities/monsters/sprites/pie.png") },
	MonsterSprites.PIZZA: { "resource" = preload("res://entities/monsters/sprites/pizza.png") },
	MonsterSprites.POPTART: { "resource" = preload("res://entities/monsters/sprites/poptart.png") },
	MonsterSprites.SPRING_ONION: { "resource" = preload("res://entities/monsters/sprites/spring onion.png") },
	MonsterSprites.TEACUP: { "resource" = preload("res://entities/monsters/sprites/teacup.png" ) }
}

enum MonsterSprites {
	AVOCADO,
	BOBA,
	BREAD,
	CARROT_CAKE,
	COFFEE,
	CORNDOG,
	DONUT,
	HOTDOG,
	JELLY,
	JUICE,
	KETCHUP,
	KISS,
	MARSHMALLOW,
	MUSTARD,
	NASILEMAK,
	ONIGIRI,
	PIE,
	PIZZA,
	POPTART,
	SPRING_ONION,
	TEACUP
}

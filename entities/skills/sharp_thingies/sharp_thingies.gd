class_name SharpThingies
extends Node2D

@export var rotation_speed: float = 180.0 
@export var radius: float = 50.0
@export var damage_multiplyer: float = 1
@export var damage_cooldown: float = .5
@export var knockback = 400

@onready var player: Player = get_tree().get_first_node_in_group("player")

var thingies: Array[SharpThingy] = []

@onready var sharp_thingy_scene: PackedScene = preload("res://entities/skills/sharp_thingies/sharp_thingy.tscn")

static var SHARP_THINGY_RESOURCES: Dictionary = {
	SharpThingyOptions.KNOIFE: {
			"resource" = preload("res://entities/skills/sprites/knoife.png"),
			"damage" = 10,
	},
	SharpThingyOptions.FORK: {
			"resource" = preload("res://entities/skills/sprites/fork.png"),
			"damage" = 5
	},
	SharpThingyOptions.SPORK: {
			"resource" = preload("res://entities/skills/sprites/spork.png"),
			"damage" = 20
	}
}

enum SharpThingyOptions {
	KNOIFE,
	FORK,
	SPORK
}


func _ready() -> void:
	#this hacky as hell boi, we will want a way to add new ones in and recalculate angle around origin for all
	for key in SHARP_THINGY_RESOURCES.keys():
		var thingy_obj = SHARP_THINGY_RESOURCES.get(key)
		var thingy: SharpThingy = sharp_thingy_scene.instantiate()
		thingy.sprite_resource = thingy_obj.resource
		thingy.damage = thingy_obj.damage * damage_multiplyer
		thingy.rotation_speed = rotation_speed
		thingy.radius = radius
		thingy.knockback = knockback
		thingy.current_angle = deg_to_rad(120*thingies.size())
		thingy.damage_cooldown = damage_cooldown
		thingies.append(thingy)
		self.add_child(thingy)


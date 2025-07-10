class_name SharpThingies
extends Node2D

static var SHARP_THINGY_RESOURCES: Dictionary = {
	SharpThingyOptions.KNOIFE: {"resource" = preload("res://entities/skills/sprites/knoife.png")},
	SharpThingyOptions.FORK: {"resource" = preload("res://entities/skills/sprites/fork.png")},
	SharpThingyOptions.SPORK: {"resource" = preload("res://entities/skills/sprites/spork.png")}
}

enum SharpThingyOptions {
	KNOIFE,
	FORK,
	SPORK
}

var thingies: Array[SharpThingy] = []

@onready var sharp_thingy_resource: PackedScene = preload("res://entities/skills/sharp_thingies/sharp_thingy.tscn")
@onready var player: Player = get_tree().get_first_node_in_group("player")

func _ready() -> void:
	var thingy: SharpThingy = sharp_thingy_resource.instantiate()
	thingy.sprite_resource = SHARP_THINGY_RESOURCES.get(SharpThingyOptions.KNOIFE).resource
	thingies.append(thingy)
	self.add_child(thingy)

@export var rotation_speed = 90.0 
@export var radius = 50.0

var current_angle = 0.0

func _physics_process(delta: float) -> void:
	current_angle += deg_to_rad(rotation_speed) * delta
	position = player.global_position + (Vector2(cos(current_angle), sin(current_angle)) * radius)

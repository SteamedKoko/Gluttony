class_name SharpThingies
extends BaseSkill

@export var rotation_speed: float = 180.0 
@export var radius: float = 50.0
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
const DEGREES_TO_POSITION_THINGIES: int = 360

func _ready() -> void:
	add_random_sharp_thing()
	rework_thingies()

func add_random_sharp_thing() -> void:
	var random_thingy = SHARP_THINGY_RESOURCES.keys().pick_random()
	return add_sharp_thingy(random_thingy)

func add_sharp_thingy(key: SharpThingyOptions) -> void:
	var thingy_obj = SHARP_THINGY_RESOURCES.get(key)
	var thingy: SharpThingy = sharp_thingy_scene.instantiate()
	thingy.sprite_resource = thingy_obj.resource
	thingy.base_damage = thingy_obj.damage
	thingy.damage = thingy_obj.damage
	thingies.append(thingy)
	add_child(thingy)

func rework_thingies() -> void:
	for i in range(thingies.size()):
		var thingy: SharpThingy = thingies[i]
		thingy.damage = thingy.base_damage * damage_multiplyer * level
		thingy.rotation_speed = rotation_speed
		thingy.radius = radius
		thingy.knockback = knockback
		thingy.damage_cooldown = damage_cooldown

		#need to get rotation of current thingy
		thingy.current_angle = deg_to_rad((DEGREES_TO_POSITION_THINGIES / thingies.size()) * i)


func level_up_action() -> void:
	add_random_sharp_thing()
	rework_thingies()

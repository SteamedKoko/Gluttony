class_name SharpThingies
extends BaseSkill

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

func _ready() -> void:
	var thingy: SharpThingy = sharp_thingy_resource.instantiate()
	print('prepping child')
	thingy.sprite_resource = SHARP_THINGY_RESOURCES.get(SharpThingyOptions.KNOIFE).resource
	print('adding child')
	thingies.append(thingy)
	self.add_child(thingy)

func rotate_thingies():
	pass
	# thingy

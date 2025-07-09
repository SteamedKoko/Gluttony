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
	thingy.sprite_resource = SHARP_THINGY_RESOURCES.get(SharpThingyOptions.KNOIFE).resource
	thingies.append(thingy)
	self.add_child(thingy)

@export var rotation_speed = 90.0  # Degrees per second, adjustable in editor
@export var radius = 50.0  # Distance from pivot to object

var current_angle = 0.0  # Tracks the current rotation angle

func _process(delta):
	# Update the angle based on rotation speed
	current_angle += deg_to_rad(rotation_speed) * delta
	# Calculate new position relative to pivot
	# position = pivot_point + Vector2(cos(current_angle), sin(current_angle)) * radius
	position = Vector2(cos(current_angle), sin(current_angle)) * radius
	# Optional: Rotate the object to face the direction of rotation
	# rotation = current_angle  # Uncomment if you want the object to rotate itself

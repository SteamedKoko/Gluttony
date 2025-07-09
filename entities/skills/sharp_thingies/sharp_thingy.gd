class_name SharpThingy
extends Attack

var sprite_resource: Resource 

func _ready() -> void:
	var sprite: Sprite2D = $Sprite2D
	sprite.texture = sprite_resource

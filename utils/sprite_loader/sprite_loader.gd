class_name SpriteLoader
extends AnimatedSprite2D

func _init() -> void:
	pass

func load_sprite(asset: Resource,width: int, height: int, columns: int, row_to_use: int, animation_name: String = "default") -> void:
	sprite_frames = SpriteFrames.new()
	for i in range(columns):
		var atlas = AtlasTexture.new()
		atlas.atlas = asset
		atlas.region = Rect2(width * i, height * (row_to_use), width, height)
		sprite_frames.add_frame(animation_name, atlas)

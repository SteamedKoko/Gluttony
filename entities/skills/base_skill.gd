class_name BaseSkill
extends Attack

@export var time_to_cast: float = 0
@export var frame_to_enable_collider: int = 0
@export var frame_to_end_collider: int = 0

var animated_sprite: AnimatedSprite2D
var execute_timer: Timer
var collider: CollisionShape2D

func _ready() -> void:
	execute_timer = Timer.new()
	execute_timer.timeout.connect(_on_execute_timeout)
	execute_timer.wait_time = time_to_cast
	execute_timer.autostart = true
	self.add_child(execute_timer)

	animated_sprite = $AnimatedSprite2D
	animated_sprite.visible = false
	animated_sprite.frame_changed.connect(_on_animated_sprite_changed)
	animated_sprite.animation_finished.connect(_on_animated_sprite_finished)

	collider = $CollisionShape2D
	collider.disabled = true


func _on_execute_timeout() -> void:
	animated_sprite.play()
	animated_sprite.visible = true
	pass


func _on_animated_sprite_changed() -> void:
	if animated_sprite.frame == frame_to_enable_collider:
		collider.disabled = false 

	if animated_sprite.frame == frame_to_end_collider:
		collider.disabled = true 


func _on_animated_sprite_finished() -> void:
	collider.disabled = true 
	animated_sprite.visible = false

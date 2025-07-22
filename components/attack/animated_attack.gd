class_name AnimatedAttack
extends Area2D

@export var animated_sprite: AnimatedSprite2D
@export var damage: int = 0
@export var damage_cooldown: float = 0
@export var knockback: float = 0
@export var frame_to_enable_collider: int = 0
@export var frame_to_end_collider: int = 0
@export var time_to_cast: float = 0

var execute_timer: Timer

signal dealt_damage()

func _ready() -> void:

	execute_timer = Timer.new()
	execute_timer.timeout.connect(_on_execute_timeout)
	execute_timer.wait_time = time_to_cast
	execute_timer.autostart = true

	self.add_child(execute_timer)
	animated_sprite.visible = false
	animated_sprite.frame_changed.connect(_on_animated_sprite_changed)
	animated_sprite.animation_finished.connect(_on_animated_sprite_finished)


func _on_execute_timeout() -> void:
	animated_sprite.play()
	animated_sprite.visible = true

func _on_animated_sprite_changed() -> void:
	if animated_sprite.frame == frame_to_enable_collider:
		monitoring = true 

	if animated_sprite.frame == frame_to_end_collider:
		monitoring = false 

func _on_animated_sprite_finished() -> void:
	monitoring = false 
	animated_sprite.visible = false

func check_and_apply_damage():
	if not monitoring:
		return

	var overlap = get_overlapping_areas()
	for ob in overlap:
		_try_hurt_hurtbox(ob)


func _try_hurt_hurtbox(ob: Node):
	if(ob is HurtBox):
		if ob.try_receive_continuous_damage(damage, knockback, damage_cooldown, name):
			dealt_damage.emit()

func _physics_process(_delta: float) -> void:
	check_and_apply_damage()

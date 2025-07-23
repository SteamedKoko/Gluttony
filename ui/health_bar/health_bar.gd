extends Control

@onready var progressBar: TextureProgressBar = $MarginContainer/TextureProgressBar
@onready var health: Health = GameManager.player.health

#listen for signal of hp changing, update vals
func _ready() -> void:
	health.health_changed.connect(update_health_bar)
	update_health_bar()

func update_health_bar():
	var new_width: float = (float(health.current_max_health) / float(health.max_health))
	var tween: Tween = create_tween()
	if(new_width < scale.x):
		tween.tween_property(self, "scale", Vector2(new_width, 1), .1)

	tween.set_parallel(true)
	tween.tween_property(progressBar, "max_value", health.current_max_health, .2)
	tween.tween_property(progressBar, "value", health.health, .2)
	await tween.finished

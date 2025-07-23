extends Control

@onready var progressBar: TextureProgressBar = $MarginContainer/TextureProgressBar
@onready var health: Health = GameManager.player.health

#listen for signal of hp changing, update vals
func _ready() -> void:
	health.health_changed.connect(update_health_bar)
	update_health_bar()

func update_health_bar():
	var new_width: float = (float(health.current_max_health) / float(health.max_health))
	scale = Vector2(new_width, 1)
	print("max health: %s, current max: %s, current health: %s" % [health.max_health, health.current_max_health, health.health])
	progressBar.max_value = health.current_max_health
	progressBar.value = health.health

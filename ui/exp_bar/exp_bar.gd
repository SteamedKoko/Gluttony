extends Control

@onready var progress: TextureProgressBar = $MarginContainer/TextureProgressBar

func _ready() -> void:
	GameManager.player.gained_exp.connect(update_progress)
	GameManager.player.leveled_up.connect(change_progress)
	change_progress()

   
func update_progress():
	var tween: Tween = create_tween()
	
	tween.tween_property(progress, "value", GameManager.player.current_exp, .2)



func change_progress():
	progress.value = 0
	progress.max_value = GameManager.player.next_level_experience
	

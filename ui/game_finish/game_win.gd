extends Control

func _ready() -> void:
	print('engage')
	


func _on_reward_button_pressed() -> void:
	%RewardButton.visible = false
	var tween = create_tween()
	%Dialogue.text = ""
	tween.tween_property(%Dialogue, "text", "Here is your reward", 1)
	tween.tween_property(%Dialogue, "text", "Here is your reward...", 1)
	tween.tween_property(%Dialogue, "text", "\nAsshole", .5)

	visible = false
	GameManager.continue_boss_mode()

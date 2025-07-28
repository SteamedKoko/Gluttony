class_name GameWinMenu
extends Control

func _ready() -> void:
	hide_menu()

func show_menu() -> void:
	visible = true
	%RewardButton.disabled = false


func hide_menu() -> void:
	visible = false
	%RewardButton.disabled = true

func _on_reward_button_pressed() -> void:
	%RewardButton.disabled = true
	var tween = create_tween()
	%Dialogue.text = ""
	tween.tween_property(%Dialogue, "text", "Here is your reward", 1)
	tween.tween_property(%Dialogue, "text", "Here is your reward...", 2)
	tween.tween_property(%Dialogue, "text", "", .2)
	tween.tween_property(%Dialogue, "text", "\nAsshole", 3)

	await tween.finished

	await get_tree().create_timer(1).timeout

	MusicPlayer.change_track(MusicPlayer.tracks.POST)

	await get_tree().create_timer(2).timeout

	GameManager.continue_boss_mode()

	hide_menu()

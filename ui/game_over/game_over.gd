extends Control

func _ready() -> void:
	visible = false

func _on_button_pressed() -> void:
	print('pressed')
	GameManager.restart()

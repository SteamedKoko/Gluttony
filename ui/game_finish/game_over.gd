extends Control

func _ready() -> void:
	visible = false

func _on_button_pressed() -> void:
	print('pressed')
	GameManager.restart()

func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_ENTER):
		GameManager.restart()

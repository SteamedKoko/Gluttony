class_name GameOverMenu
extends Control

func _ready() -> void:
	hide_menu()

func show_menu() -> void:
	visible = true
	$ColorRect/MarginContainer/VBoxContainer/Button.disabled = false


func hide_menu() -> void:
	visible = false
	$ColorRect/MarginContainer/VBoxContainer/Button.disabled = true

func _on_button_pressed() -> void:
	GameManager.restart()
	hide_menu()


func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_ENTER) and visible:
		GameManager.restart()

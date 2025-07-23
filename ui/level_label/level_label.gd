extends Control

@onready var label: RichTextLabel = $RichTextLabel

func _ready() -> void:
    GameManager.player.leveled_up.connect(adjust_level)
    adjust_level()

func adjust_level() -> void:
    label.text = str(GameManager.player.current_level)

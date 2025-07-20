extends Control

@onready var levels_left: int = 0

const skill_options_to_add = 3
var skill_options = []

func _ready() -> void:
    GameManager.player.leveled_up.connect(func (): levels_left += 1)
    visible = false



func opt_for_skill() -> void:
    get_tree().paused = true
    self.visible = true


    # %SkillOptionContainer.add_child()
    await get_tree().create_timer(2).timeout

    self.visible = false
    levels_left -=1

    if levels_left > 0:
        opt_for_skill()
    get_tree().paused = false

func _process(_delta: float) -> void:
    if levels_left > 0:
        opt_for_skill()

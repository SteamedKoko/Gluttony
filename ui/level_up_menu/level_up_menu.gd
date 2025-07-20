extends Control

@onready var levels_left: int = 0
@onready var skill_option_resource = preload("res://ui/level_up_menu/skill_option.tscn")

const skill_options_to_add = 3
var skill_options = []

var ct = 1
func _ready() -> void:
	GameManager.player.leveled_up.connect(func (): levels_left += 1)
	visible = false



func opt_for_skill() -> void:
	print('go ', levels_left)
	get_tree().paused = true
	self.visible = true


	for i in range(skill_options_to_add):
		add_random_option()

	await get_tree().create_timer(1).timeout

	self.visible = false
	for child in %SkillOptionContainer.get_children():
		child.call_deferred('queue_free')

	levels_left = max(0, levels_left-1)

	if levels_left > 0:
		opt_for_skill()
		return

	get_tree().paused = false

func add_random_option():
	var option: SkillOption = skill_option_resource.instantiate()
	skill_options.append(option)
	option.text = str(ct)
	ct += 1
	%SkillOptionContainer.add_child(option)


func _process(_delta: float) -> void:
	if levels_left > 0:
		opt_for_skill()

extends Control

@onready var levels_left: int = 0
@onready var skill_option_resource = preload("res://ui/level_up_menu/skill_option.tscn")

const skill_options_to_add = 3

func _ready() -> void:
	GameManager.player.leveled_up.connect(func (): levels_left += 1)
	visible = false


func opt_for_skill() -> void:
	get_tree().paused = true

	#do this before it's visible so that it will be placed in the right spot
	populate_random_skills()
	self.visible = true


func finish_skill_choice(skill: GlobalSkillManager.skills) -> void:
	self.visible = false
	for child in %SkillOptionContainer.get_children():
		child.call_deferred('queue_free')

	levels_left = max(0, levels_left-1)
	GlobalSkillManager.add_skill(skill)

	if levels_left > 0:
		opt_for_skill()
		return

	get_tree().paused = false

func populate_random_skills():
	var skills = GlobalSkillManager.get_random_skills(skill_options_to_add)
	for skill in skills:
		var option: SkillOption = skill_option_resource.instantiate()
		option.skill = GlobalSkillManager.skills.get(skill)
		option.chose_skill.connect(finish_skill_choice)
		%SkillOptionContainer.add_child(option)
	

func _process(_delta: float) -> void:
	if levels_left > 0:
		opt_for_skill()

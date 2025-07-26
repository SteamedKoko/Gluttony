class_name SkillOption
extends MarginContainer

var skill: SkillManager.skills
var detriment: SkillManager.detriments
var button_number: int

signal chose_skill(skill: SkillManager.skills)

func _ready() -> void:
	var skill_info = GameManager.skill_manager.get_skill(skill)
	var detriment_info = GameManager.skill_manager.get_detriment(detriment)
	%SkillSprite.texture = skill_info.get("icon")
	%SkillDescription.text = skill_info.get("description")
	%DetrimentDescription.text = detriment_info.get("name")
	%TakeSkillButton.text = "Press " + str(button_number-48)
	%TakeSkillButton.pressed.connect(pick_skill)


func pick_skill():
	chose_skill.emit(skill, detriment)

func _process(_delta: float) -> void:
	if Input.is_key_pressed(button_number):
		pick_skill()

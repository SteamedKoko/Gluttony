class_name SkillOption
extends MarginContainer

var skill: SkillManager.skills
var detriment: SkillManager.detriments

signal chose_skill(skill: SkillManager.skills)

func _ready() -> void:
	var skill_info = GameManager.skill_manager.get_skill(skill)
	var detriment_info = GameManager.skill_manager.get_detriment(detriment)
	%SkillSprite.texture = skill_info.get("icon")
	%SkillDescription.text = skill_info.get("description")
	%DetrimentDescription.text = detriment_info.get("name")
	%TakeSkillButton.text = "Take"
	%TakeSkillButton.pressed.connect(func(): chose_skill.emit(skill, detriment))

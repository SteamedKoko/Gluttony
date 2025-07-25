class_name SkillOption
extends MarginContainer

var skill: GlobalSkillManager.skills
var detriment: GlobalSkillManager.detriments

signal chose_skill(skill: GlobalSkillManager.skills)

func _ready() -> void:
	var skill_info = GlobalSkillManager.get_skill(skill)
	var detriment_info = GlobalSkillManager.get_detriment(detriment)
	%SkillSprite.texture = skill_info.get("icon")
	%SkillDescription.text = skill_info.get("description")
	%DetrimentDescription.text = detriment_info.get("name")
	%TakeSkillButton.text = "Take"
	%TakeSkillButton.pressed.connect(func(): chose_skill.emit(skill, detriment))

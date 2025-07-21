class_name SkillOption
extends MarginContainer

var skill: GlobalSkillManager.skills

signal chose_skill(skill: GlobalSkillManager.skills)

func _ready() -> void:
	print(skill)
	var skill_info = GlobalSkillManager.get_skill(skill)
	%SkillSprite.texture = skill_info.get("icon")
	%SkillDescription.text = skill_info.get("description")
	%TakeSkillButton.text = "Take"
	%TakeSkillButton.pressed.connect(func(): chose_skill.emit(skill))

class_name SkillManager
extends Node2D


enum skills {
	AURA, #todo
	DASH,
	FIRE,
	GRINDER, #todo
	LIGHTNING,
	SHARP_THINGIES
}

enum detriments { #todo all
	TAKE_MORE_DAMAGE,
	MOVE_SLOWER,
	VACUUM,
	MAKE_ENEMIES_BIGGER,
	ENEMIES_SHOOT_DEATH_PELLETS,
	MAKE_ENEMIES_FASTER 
}

var active_skills = {}

var ALL_SKILLS = {
	skills.AURA: {
		# "scene": preload()
	},
	skills.DASH: {
		"scene": preload("res://entities/skills/dash/dash.tscn")
	},
	skills.FIRE: {
		"scene": preload("res://entities/skills/fire/fire.tscn")
	},
	skills.GRINDER: {
		# "scene": 
	},
	skills.LIGHTNING: {
		"scene": preload("res://entities/skills/lightning/lightning.tscn")
	},
	skills.SHARP_THINGIES: {
		"scene": preload("res://entities/skills/sharp_thingies/sharp_thingies.tscn")
	}
}


func add_skill(skill_enum: skills) -> void:
	var skill = active_skills.get(skill_enum)
	if skill:
		return #levelup
	var new_skill = ALL_SKILLS.get(skill_enum).scene.instantiate()
	active_skills[skill_enum] = new_skill
	add_child(new_skill)

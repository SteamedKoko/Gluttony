extends Node2D


enum skills {
	# AURA, #todo
	DASH,
	FIRE,
	# GRINDER, #todo
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
	# skills.AURA: {
		# "scene": preload()
	# },
	skills.DASH: {
		"description": "Allows the player to dash, dummy",
		"icon": preload("res://entities/skills/sprites/icons/dash_icon.png"),
		"name": "Dash",
		"scene": preload("res://entities/skills/dash/dash.tscn"),
	},
	skills.FIRE: {
		"description": "Occasionally shoot fire in front of you",
		"icon": preload("res://entities/skills/sprites/icons/fire_icon.png"),
		"name": "Fire",
		"scene": preload("res://entities/skills/fire/fire.tscn"),
	},
	# skills.GRINDER: {
		# "scene": 
	# },
	skills.LIGHTNING: {
		"description": "A flash of lightning strikes areas randomly",
		"icon": preload("res://entities/skills/sprites/icons/lightning_icon.png"),
		"name": "Lightning",
		"scene": preload("res://entities/skills/lightning/lightning.tscn"),
	},
	skills.SHARP_THINGIES: {
		"description": "Sharp thingies rotate around the player, TEEHEE",
		"icon": preload("res://entities/skills/sprites/icons/sharp_thingies_icon.png"),
		"name": "Sharp Thingies",
		"scene": preload("res://entities/skills/sharp_thingies/sharp_thingies.tscn")
	}
}

func get_skill(skill_enum: skills) -> Dictionary:
	return ALL_SKILLS.get(skill_enum)


func get_random_skills(numberToGrab: int) -> Array:
	var randomized_array: Array = skills.keys()
	print(randomized_array)
	randomized_array.shuffle()
	return randomized_array.slice(0, numberToGrab)


func add_skill(skill_enum: skills) -> void:
	var skill = active_skills.get(skill_enum)
	if skill:
		skill.level += 1
		return
	var new_skill = ALL_SKILLS.get(skill_enum).scene.instantiate()
	active_skills[skill_enum] = new_skill
	add_child(new_skill)

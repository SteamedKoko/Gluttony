class_name BossMonster
extends BaseMonster

signal boss_died

func _ready() -> void:
	$Health.health_depleted.connect(perish)

func perish():
	boss_died.emit()
	super.perish()

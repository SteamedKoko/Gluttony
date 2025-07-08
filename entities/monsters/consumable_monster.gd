extends BaseMonster


func _on_attack_dealt_damage() -> void:
	perish()


func _on_health_health_delpleted() -> void:
	perish()


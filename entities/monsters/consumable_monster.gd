extends BaseMonster


func _on_health_health_delpleted() -> void:
	perish()


func _on_attack_dealt_damage() -> void:
	perish()



func _on_hurt_box_got_knocked_back(knockback:Variant) -> void:
	pass # Replace with function body.


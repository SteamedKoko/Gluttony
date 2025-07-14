extends Node2D

var hurt_box: HurtBox

func _ready() -> void:
    hurt_box = get_parent().get_node("HurtBox")
    hurt_box.took_damage.connect(spawn_damage)


func spawn_damage(damage: float):
    if(hurt_box):
        DamageNumber.display_damage(damage, global_position)

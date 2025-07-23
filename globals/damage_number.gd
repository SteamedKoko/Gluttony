extends Node

const OUTLINE_COLOR: Color = "#000"
const FONT_SIZE: int = 18
const OUTLINE_SIZE: int = 2


func display_damage(amount: int, position: Vector2, font_color: Color):
	var number: Label = Label.new()
	number.text = str(amount)
	number.z_index = 5
	number.global_position = position

	number.label_settings = LabelSettings.new()

	number.label_settings.font_color = font_color
	number.label_settings.font_size = FONT_SIZE
	number.label_settings.outline_color = OUTLINE_COLOR
	number.label_settings.outline_size = OUTLINE_SIZE

	call_deferred("add_child", number)
	
	await number.resized
	number.pivot_offset = Vector2(number.size / 2)

	var tween: Tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(
		number, "position:y", number.position.y - 24, 0.15
	).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		number, "position:x", number.position.x + 12, 0.15
	).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		number, "position:y", number.position.y, 0.20
	).set_ease(Tween.EASE_IN).set_delay(0.25)
	tween.tween_property(
		number, "position:x", number.position.x+16, 0.25
	).set_ease(Tween.EASE_IN).set_delay(0.25)
	tween.tween_property(
		number, "scale", Vector2.ZERO, 0.25
	).set_ease(Tween.EASE_IN).set_delay(0.2)

	await tween.finished

	number.queue_free()

extends Node2D

@onready var label = $Label

func set_text(text: String, color: Color = Color.WHITE):
	label.text = text
	label.modulate = color
	animate()

func animate():
	var tween = create_tween()
	tween.tween_property(self, "global_position", global_position + Vector2(0, -80), 1.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(self, "modulate:a", 0.0, 1.5)
	await tween.finished
	queue_free()

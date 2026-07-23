class_name CustomCamera
extends Camera2D

static var current_camera: CustomCamera

var transition_rect: ColorRect

static var TRANSPARENT_BLACK: Color = Color(0.0, 0.0, 0.0, 0.0)

func _ready() -> void:
	CustomCamera.current_camera = self
	var cv_layer: CanvasLayer = CanvasLayer.new()
	transition_rect = ColorRect.new()
	transition_rect.size = Vector2(9999, 9999)
	transition_rect.color = TRANSPARENT_BLACK
	add_child(cv_layer)
	cv_layer.add_child(transition_rect)

func fade_to_black() -> void:
	do_transition(
		transition_rect.color, Color.BLACK
	)

func fade_to_clear() -> void:
	do_transition(
		transition_rect.color, TRANSPARENT_BLACK
	)

func do_transition(
	start_clr: Color, end_clr: Color, trans_time: float = 0.2
) -> void:
	transition_rect.color = start_clr
	create_tween().tween_property(
		transition_rect, "color", end_clr, trans_time
	)

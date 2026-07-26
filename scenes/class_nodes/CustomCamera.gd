class_name CustomCamera
extends Camera2D

static var current_camera: CustomCamera

var transition_rect: ColorRect

static var TRANSPARENT_BLACK: Color = Color(0.0, 0.0, 0.0, 0.0)

func _ready() -> void:
	CustomCamera.current_camera = self
	create_transition_rect()
	create_background()
	
func create_canvas_layer() -> CanvasLayer:
	var cv_layer: CanvasLayer = CanvasLayer.new()
	add_child(cv_layer)
	return cv_layer

func create_transition_rect() -> void:
	var cv_layer: CanvasLayer = create_canvas_layer()
	transition_rect = ColorRect.new()
	transition_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	transition_rect.size = Vector2(9999, 9999)
	transition_rect.color = TRANSPARENT_BLACK
	cv_layer.add_child(transition_rect)

func create_background() -> void:
	var cv_layer: CanvasLayer = create_canvas_layer()
	cv_layer.layer = -99
	var t_rect: TextureRect = TextureRect.new()
	## assets/.../environment/background/wood_tile.png
	t_rect.texture = load("uid://cjf2tdpqv4wqn")
	t_rect.stretch_mode = TextureRect.STRETCH_TILE
	t_rect.size = Vector2(9999, 9999)
	cv_layer.add_child(t_rect)

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

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
	
	var overlay: TextureRect = TextureRect.new()
	overlay.texture = load("res://assets/images/ui/theme/ScreenEdgeGradient.tres")
	overlay.size = Vector2(1600, 900)
	cv_layer.add_child(overlay)


func fade_to_black(t_time: float = 0.35) -> void:
	await do_transition(
		transition_rect.color, Color.BLACK, t_time
	)

func fade_to_clear(t_time: float = 0.35) -> void:
	await do_transition(
		transition_rect.color, TRANSPARENT_BLACK, t_time
	)

func do_transition(
	start_clr: Color, end_clr: Color, trans_time: float = 0.35
) -> void:
	transition_rect.color = start_clr
	await create_tween().tween_property(
		transition_rect, "color", end_clr, trans_time
	).finished


func transition_scene(pck: PackedScene) -> void:
	await fade_to_black()
	get_tree().change_scene_to_packed(pck)
	fade_to_clear()

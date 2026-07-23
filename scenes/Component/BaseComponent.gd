@icon("res://scenes/Component/build_circle_blue.png")
class_name BaseComponent
extends Node2D

@export var output_type : GlobalEnum.ComponentIOType
@export var input_type : GlobalEnum.ComponentIOType

# Nodes waarvan de posities worden gebruikt om te checken voor een connectie
@export var input_anchor : Node2D 
@export var output_anchor : Node2D

@export var output_direction : GlobalEnum.ComponentIODirection
@export var input_direction : GlobalEnum.ComponentIODirection

var input_connection : ComponentConnection
var output_connection : ComponentConnection

var is_hovered : bool = false
var is_left_mouse_down : bool = false

func _process(_delta):
	# DEBUG
	if output_connection or input_connection:
		$HoverShape.debug_color = Color.GREEN
	else:
		$HoverShape.debug_color = Color.RED

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			is_left_mouse_down = event.pressed && is_hovered
	
	if event is InputEventMouseMotion:
		if is_left_mouse_down && is_hovered:
			self.global_position += event.relative
			try_connect()
			get_viewport().set_input_as_handled()

func try_connect() -> void:
	ComponentConnector.find_connection(self)

# Implementeren in child classes
func start() -> void:
	pass

# Implementeren in child classes
func reset() -> void:
	pass

# Implementeren in child classes
# Niet zelf callen!!
# Dit wordt gebruikt door de ComponentConnector
func _find_connection(anchor: Node2D, direction: GlobalEnum.ComponentIODirection) -> BaseComponent:
	var space_state : PhysicsDirectSpaceState2D = get_world_2d().direct_space_state
	var origin : Vector2 = anchor.global_position
	var end : Vector2 = origin + ComponentConnector.io_direction_to_vector(direction) * 5000
	var query : PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.create(origin, end)
	query.collide_with_areas = true
	var result : Dictionary = space_state.intersect_ray(query)
	if result:
		if result.collider != self and result.collider is BaseComponent:
			return result.collider
	return null

func _on_mouse_shape_entered(shape_idx):
	if $HoverShape.get_index() == shape_idx:
		is_hovered = true


func _on_mouse_shape_exited(shape_idx):
	if $HoverShape.get_index() == shape_idx:
		is_hovered = false

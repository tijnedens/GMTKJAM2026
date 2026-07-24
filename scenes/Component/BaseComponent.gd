@icon("res://scenes/Component/build_circle_blue.png")
class_name BaseComponent
extends CharacterBody2D

@export var output_type : GlobalEnum.ComponentIOType
@export var input_type : GlobalEnum.ComponentIOType

# Nodes waarvan de posities worden gebruikt om te checken voor een connectie
@export var input_anchor : Node2D 
@export var output_anchor : Node2D

@export var output_direction : GlobalEnum.ComponentIODirection
@export var input_direction : GlobalEnum.ComponentIODirection
@export var no_collision : bool
@export var disable_drag_drop : bool 
var default_disable_drag_drop : bool

var input_connection : ComponentConnection
var output_connection : ComponentConnection

var drag_speed : float = 100.0
var is_hovered : bool = false
var is_dragging : bool = false
var is_left_mouse_down : bool = false
var mouse_relative : Vector2 = Vector2.ZERO
var pin_delta : Vector2 = Vector2.ZERO

func _ready():
	ResetManager.register_component(self)
	set_move_collision(!no_collision)
	default_disable_drag_drop = disable_drag_drop

func _physics_process(_delta):
	if (is_dragging):
		var target = (get_global_mouse_position() - global_position - pin_delta)
		velocity = target.limit_length(drag_speed)
		set_move_collision(false)
	else: 
		velocity = Vector2.ZERO
		if !no_collision:
			set_move_collision(true)
	mouse_relative = Vector2.ZERO
	move_and_collide(velocity)

func set_move_collision(enabled : bool):
	$CollisionShape.disabled = !enabled

func _input(event):
	if disable_drag_drop:
		return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			is_left_mouse_down = event.pressed && is_hovered
			if event.pressed && is_hovered:
				pin_delta = event.global_position - self.global_position
				get_viewport().set_input_as_handled()
			if is_dragging && !event.pressed:
				on_drop()
				is_dragging = false
	
	if event is InputEventMouseMotion:
		if is_left_mouse_down && (is_hovered || is_dragging):
			mouse_relative = event.relative
			if !is_dragging:
				on_pickup()
			is_dragging = true
			try_connect()

func try_connect() -> void:
	ComponentConnector.find_connection(self)

# Implementeren in child classes
func start() -> void:
	disable_drag_drop = true

# Implementeren in child classes
func reset() -> void:
	disable_drag_drop = default_disable_drag_drop

# Implementeren in child classes
func on_drop() -> void:
	pass

# Implementeren in child classes
func on_pickup() -> void:
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
			var found_component : BaseComponent = result.collider
			if found_component.input_type == GlobalEnum.ComponentIOType.RANGED:
				return found_component
	return null

func get_shape_by_index(idx: int) -> CollisionShape2D:
	var i = 0
	for child in get_children():
		if child is CollisionShape2D:
			if i == idx:
				return child
			i += 1
	return null

func _on_mouse_shape_entered():
	is_hovered = true


func _on_mouse_shape_exited():
	is_hovered = false

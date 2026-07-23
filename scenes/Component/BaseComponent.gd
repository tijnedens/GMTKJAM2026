@icon("res://scenes/Component/build_circle_blue.png")
class_name BaseComponent
extends Node2D

@export var output_type : GlobalEnum.ComponentIOType
@export var input_type : GlobalEnum.ComponentIOType

@export var output_direction : GlobalEnum.ComponentIODirection
@export var input_direction : GlobalEnum.ComponentIODirection

var connected_output : BaseComponent
var connected_input : BaseComponent

var is_hovered : bool = false
var is_left_mouse_down : bool = false

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			is_left_mouse_down = event.pressed && is_hovered
	
	if event is InputEventMouseMotion:
		if is_left_mouse_down:
			self.global_position += event.relative
			get_viewport().set_input_as_handled()


func _on_mouse_shape_entered(shape_idx):
	if $HoverShape.get_index() == shape_idx:
		is_hovered = true


func _on_mouse_shape_exited(shape_idx):
	if $HoverShape.get_index() == shape_idx:
		is_hovered = false

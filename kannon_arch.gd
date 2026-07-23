extends Node2D

var shoot_dir : Vector2 = Vector2.ZERO
var shoot_str : int = 500

@onready var kogel: RigidBody2D = $"../kogel"

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	
	shoot_dir = global_position.direction_to(get_global_mouse_position()).normalized()
	var target_angle = Vector2.UP.angle_to(shoot_dir)
	rotation = target_angle
	
	if Input.is_action_just_pressed("ui_accept") and kogel.freeze:
		kogel.freeze = false
		kogel.gravity_scale = 1.0
		kogel.apply_impulse(shoot_dir * shoot_str)
		
	
	if kogel.freeze:
		var kogel_pos = global_position + shoot_dir*150
		kogel.position = kogel_pos
		kogel.rotation = rotation

	if Input.is_action_just_pressed("open_menu"):
		get_tree().reload_current_scene()

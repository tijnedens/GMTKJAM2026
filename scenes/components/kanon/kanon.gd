#class_name kanonComponent
extends BaseComponent

var shoot_angle = 0
var shoot_dir = Vector2.ZERO
var shoot_str = 1000

@onready var kanon_pivot: Node2D = $Kanon_pivot
@onready var gnogel: RigidBody2D = $Gnogel


func _find_connection(anchor: Node2D, direction: GlobalEnum.ComponentIODirection) -> BaseComponent:
	return null

func _process(_delta):
	#if Input.is_action_just_pressed("ui_accept"):
		#_on_vlam()

	if is_hovered and Input.is_action_just_pressed("right_click"):
		if Input.is_action_pressed("shift"):
			shoot_angle -= 0.1
		else:
			shoot_angle += 0.1
	
	kanon_pivot.rotation = shoot_angle	
	shoot_dir = Vector2.UP.rotated(shoot_angle)
	
	if gnogel.freeze:
		var kogel_pos = kanon_pivot.global_position +Vector2(-10,0) + shoot_dir*180
		gnogel.global_position = kogel_pos
		gnogel.rotation = shoot_angle

	if Input.is_action_just_pressed("open_menu"):
		get_tree().reload_current_scene()

func _on_vlam():
	var timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.wait_time = 2.0
	timer.autostart = true
	timer.timeout.connect(_on_vlam_timer_timeout)
	timer.start()
	
	
func _on_vlam_timer_timeout():
	gnogel.freeze = false
	gnogel.gravity_scale = 1.0
	gnogel.apply_impulse(shoot_dir * shoot_str)
	



func _on_medium_gear_component_inventory_item_reached() -> void:
	_on_vlam()
	print("vlam aan")

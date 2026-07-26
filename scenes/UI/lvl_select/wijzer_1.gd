extends Sprite2D

@export var wijzer2: Sprite2D

func _process(delta: float) -> void:
	
	var true_rot: float = rotation
	
	look_at(get_global_mouse_position())
	rotation += 0.5 * PI
	
	var target_rot: float = rotation
	rotation = lerp_angle(true_rot, target_rot, 0.03)
	
	wijzer2.rotation = rotation / 60 + 0.5*PI

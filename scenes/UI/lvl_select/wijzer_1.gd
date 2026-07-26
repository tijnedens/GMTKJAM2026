extends Sprite2D

@export var wijzer2: Sprite2D
var music_changed: bool = false

func _process(delta: float) -> void:
	
	var true_rot: float = rotation
	
	look_at(get_global_mouse_position())
	rotation += 0.5 * PI
	
	var target_rot: float = rotation
	rotation = lerp_angle(true_rot, target_rot, 0.03)
	
	wijzer2.rotation = rotation / 12 + 0.5*PI

	#print(wijzer2.rotation_degrees)
	if not music_changed and wijzer2.rotation_degrees > 360 * 2:
		MusicManager.play_music(MusicManager.KONT_LIED)
		music_changed = true

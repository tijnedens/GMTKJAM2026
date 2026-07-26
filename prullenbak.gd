extends Node2D
@onready var area_2d: Area2D = $Area2D
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

func _process(delta: float) -> void:
	if global_position.distance_to(get_global_mouse_position()) < 64:
		sprite_2d.play("Open")
	else:
		sprite_2d.play("default")

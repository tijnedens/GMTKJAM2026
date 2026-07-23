class_name GearVisualizer
extends ComponentVisualizer

@export var anim_player: AnimationPlayer
@export var rotation_speed_multiplier: float = 1.0

func visualize_start(gear_speed: float) -> void:
	anim_player.speed_scale = (
		(gear_speed/100) * rotation_speed_multiplier
	)
	anim_player.play("rotate")

func visualize_jam() -> void:
	anim_player.speed_scale = 1
	anim_player.play("jammed")

func reset() -> void:
	anim_player.speed_scale = 1
	anim_player.play("RESET")

class_name LevelSelectButton
extends Node2D

@export var level_path: String
@export var label_text: String = "1"

@export var small_size: float = 0.5
var current_sprite_tween: Tween

@onready var sprite: Sprite2D = %Sprite

func _ready() -> void:
	sprite.scale = Vector2(small_size, small_size)
	%Label.text = label_text

func set_sprite_size(size: float) -> void:
	if current_sprite_tween:
		current_sprite_tween.stop()
	current_sprite_tween = create_tween()
	await current_sprite_tween.tween_property(
		sprite, "scale", Vector2(size, size), 0.3
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).finished
	current_sprite_tween = null
	

func _on_mouse_detector_mouse_entered() -> void:
	set_sprite_size(1)

func _on_mouse_detector_mouse_exited() -> void:
	set_sprite_size(small_size)


func _on_mouse_detector_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left_click"):
		if level_path == "":
			push_error("No level path defined in level select button!")
			return
		var pck: PackedScene = load(level_path)
		CustomCamera.current_camera.transition_scene(pck)

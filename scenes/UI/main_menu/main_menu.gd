class_name MainMenu
extends Control

@onready var camera: CustomCamera = %CustomCamera

var showing_credits: bool = false

func _ready() -> void:
	%SettingsMenu.visible = false
	if randf() < 0.01:
		%Levels.text = "GNEVELS"
	if randf() < 0.01:
		%Settings.text = "GNETTINGS"
	if randf() < 0.01:
		%Credits.text = "GNEDITS"
	if randf() < 0.01:
		%Quit.text = "GNUIT"


func _on_levels_pressed() -> void:
	CustomCamera.current_camera.transition_scene(
		load("res://scenes/UI/lvl_select/level_select.tscn")
	)

func _on_quit_pressed() -> void:
	RenderingServer.set_default_clear_color(Color.BLACK)
	await CustomCamera.current_camera.fade_to_black(1)
	get_tree().quit()


func _on_credits_pressed() -> void:
	toggle_camera_height()

func toggle_camera_height() -> void:
	if showing_credits:
		showing_credits = false
		move_camera_to_height(0)
	else:
		showing_credits = true
		move_camera_to_height(700)

func move_camera_to_height(height: float) -> void:
	create_tween().tween_property(
		camera, "position", Vector2(0, height), 0.4
	).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	
	
	
	

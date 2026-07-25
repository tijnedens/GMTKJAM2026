class_name MainMenu
extends Control

func _ready() -> void:
	%SettingsMenu.visible = false


func _on_levels_pressed() -> void:
	CustomCamera.current_camera.transition_scene(
		load("res://scenes/UI/lvl_select/level_select.tscn")
	)

func _on_quit_pressed() -> void:
	RenderingServer.set_default_clear_color(Color.BLACK)
	await CustomCamera.current_camera.fade_to_black(1)
	get_tree().quit()

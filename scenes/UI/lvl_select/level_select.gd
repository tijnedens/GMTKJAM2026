extends Control


func _on_main_menu_pressed() -> void:
	CustomCamera.current_camera.transition_scene(
		load("res://scenes/UI/main_menu/main_menu.tscn")
	)

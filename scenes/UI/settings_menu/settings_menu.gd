class_name SettingsMenu
extends Control

@export var hide_on_ready: bool = true
@export var fade_on_button_press: bool = true

func _ready() -> void:
	if hide_on_ready:
		hide()
	%SfxVolumeSlider.value = SettingsManager.settings.sfx_volume
	%MusicVolumeSlider.value = SettingsManager.settings.music_volume

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		if visible:
			fade_away()
		else:
			appear()
			
func _on_sfx_volume_slider_value_changed(value: float) -> void:
	SettingsManager.settings.sfx_volume = value

func _on_music_volume_slider_value_changed(value: float) -> void:
	SettingsManager.settings.music_volume = value


func appear() -> void:
	self.modulate = Color.TRANSPARENT
	self.show()
	await create_tween().tween_property(
		self, "modulate", Color.WHITE, 0.3
	).finished

func fade_away() -> void:
	await create_tween().tween_property(
		self, "modulate", Color(0.0, 0.0, 0.0, 0.0), 0.3
	).finished
	hide()
	modulate = Color.WHITE


func _on_button_pressed() -> void:
	if fade_on_button_press:
		fade_away()


func _on_main_menu_button_pressed() -> void:
	await CustomCamera.current_camera.transition_scene(
		load("res://scenes/UI/main_menu/main_menu.tscn")
	)

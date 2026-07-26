class_name SettingsMenu
extends Control

func _on_sfx_volume_slider_value_changed(value: float) -> void:
	SettingsManager.settings.sfx_volume = value

func _on_music_volume_slider_value_changed(value: float) -> void:
	SettingsManager.settings.music_volume = value

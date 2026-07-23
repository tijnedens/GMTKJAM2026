class_name CustomAudioPlayer
extends AudioStreamPlayer

enum Type {
	SFX,
	MUSIC
}
@export var type: Type

func _ready() -> void:
	SettingsManager.settings.volume_updated.connect(update_volume)

func update_volume() -> void:
	var cur_settings: Settings = SettingsManager.current_settings
	if type == Type.SFX:
		self.volume_linear = cur_settings.sfx_volume
	elif type == Type.MUSIC:
		self.volume_linear = cur_settings.music_volume
	else:
		push_warning("invalid type selected for StandardAudioPlayer")

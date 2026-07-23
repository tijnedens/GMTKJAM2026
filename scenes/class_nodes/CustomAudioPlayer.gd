class_name CustomAudioPlayer
extends AudioStreamPlayer

enum Type {
	SFX,
	MUSIC
}
@export var type: Type

@export var volume_multiplier: float = 1.0

func _ready() -> void:
	SettingsManager.settings.volume_updated.connect(update_volume)

func update_volume() -> void:
	self.volume_linear = get_volume()

func get_volume() -> float:
	var settings: Settings = SettingsManager.settings
	match type:
		Type.SFX:
			return SettingsManager.settings.sfx_volume * volume_multiplier
		Type.MUSIC, _:
			return SettingsManager.settings.music_volume * volume_multiplier

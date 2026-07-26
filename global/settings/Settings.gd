class_name Settings extends Resource

signal volume_updated

@export var sfx_volume: float = 0.6 :
	set(value):
		sfx_volume = value
		volume_updated.emit()
@export var music_volume: float = 0.6 :
	set(value):
		music_volume = value
		volume_updated.emit()

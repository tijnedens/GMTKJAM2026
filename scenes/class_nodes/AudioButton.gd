class_name AudioButton
extends Button


@export var volume_multiplier: float = 1.0
@export var custom_audio: AudioStream
var audio_player: CustomAudioPlayer

func _ready() -> void:
	audio_player = CustomAudioPlayer.new()
	if custom_audio:
		audio_player.stream = custom_audio
	else:
		audio_player.stream = load(
			"res://assets/audio/sfx/ui/klik.mp3"
		)
	audio_player.volume_linear = volume_multiplier
	add_child(audio_player)
	pressed.connect(audio_player.play)

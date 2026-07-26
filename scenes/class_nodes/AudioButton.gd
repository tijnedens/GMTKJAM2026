class_name AudioButton
extends Button

var audio_player: CustomAudioPlayer

func _ready() -> void:
	audio_player = CustomAudioPlayer.new()
	audio_player.stream = load(
		"res://assets/audio/sfx/ui/klik.mp3"
	)
	audio_player.volume_db = 15
	add_child(audio_player)
	pressed.connect(audio_player.play)

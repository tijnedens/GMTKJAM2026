## MusicManager
extends Node

var GAYB_GEMEEN: AudioStream = load(
	"res://assets/audio/music/PLACEHOLDER/Gayb-Gemeen_Modus.wav"
)
var KASTEEL_DEUR: AudioStream = load(
	"res://assets/audio/music/PLACEHOLDER/kasteel_deur_boss_theme_0-1.wav"
)

var player: CustomAudioPlayer = CustomAudioPlayer.new()

func _ready() -> void:
	player.type = CustomAudioPlayer.Type.MUSIC
	add_child(player)

func play_music(new_stream: AudioStream) -> void:
	if player.stream:
		await create_tween().tween_property(
			player, "volume_linear", 0, 1.0
		).finished
	else:
		player.volume_linear = 0.0
	player.stream = new_stream
	player.play()
	await create_tween().tween_property(
		player, "volume_linear", player.get_volume(), 1.0
	).finished
	print(player.volume_multiplier)

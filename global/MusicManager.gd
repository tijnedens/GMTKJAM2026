## MusicManager
extends Node

var music_dict: Dictionary[String, AudioStream] = {
	
}

var player: CustomAudioPlayer = CustomAudioPlayer.new()

func _ready() -> void:
	player.type = CustomAudioPlayer.Type.MUSIC
	add_child(player)

func play_music(new_stream: AudioStream) -> void:
	if player.stream:
		await create_tween().tween_property(
			player, "volume_linear", 0, 1.0
		).finished
	player.stream = new_stream
	create_tween().tween_property(
		player, "volume_linear", player.get_volume(), 1.0
	)

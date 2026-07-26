
extends BaseComponent

@onready var big_bell_visualizer: BigBellVisualizer = $BigBellVisualizer
@onready var audio_player: CustomAudioPlayer = $CustomAudioPlayer

func _process(_delta):
	pass

func reset() -> void:
	big_bell_visualizer.reset()

func _on_hit():
	if get_parent().timer_running:
		big_bell_visualizer.visualize_start()
		get_parent().stop_timer()
		audio_player.play()

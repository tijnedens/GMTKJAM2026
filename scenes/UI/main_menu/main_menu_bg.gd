extends Control

func _process(delta: float) -> void:
	%MinuteHand.rotation_degrees += delta * 60
	%HourHand.rotation_degrees += delta * 60/12

extends Node2D

var timer_running: bool = false
var time_passed: float
var time_left: float
var time_target: float = 10

@onready var label: Label = $Label
@onready var start_button: Button = $startButton

func _ready() -> void:
	time_left = time_target-time_passed
	start_button.pressed.connect(_on_start_button_pressed)
	label.text = get_converted_time(time_left)

func start_timer() -> void:
	time_passed = 0
	timer_running = true

func _on_start_button_pressed():
	if !timer_running:
		start_timer()

func _process(delta: float) -> void:
	
	if timer_running:
		time_left = time_target-time_passed
		time_passed += delta
		
		if time_left > 0:
			label.text = get_converted_time(time_left)
		else:
			label.text = get_converted_time(time_passed-time_target)
			label.add_theme_color_override("font_color", Color(1.0, 0.0, 0.0, 1.0))
			

func get_converted_time(time) -> String:
	var minutes: int = floor(time / 60.0)
	var seconds: int = time - minutes * 60
	var miliseconds: int = int(time * 100.0) % 100
	var time_string: String = "%02d:%02d:%02d" % [minutes, seconds, miliseconds]
	return time_string

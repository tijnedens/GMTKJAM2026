extends Node2D

var timer_running: bool = false
var time_passed: float
var time_left: float
var time_target: float = 8
var time_end: float

@onready var label: Label = $Label
@onready var start_button: Button = $startButton
@export var first_gear : GearComponent
@export var end_bell : BaseComponent
@export var gnollars: int
@onready var gnollar_indicator: Label = $GnollarIndicator
@onready var reset_button: Button = $ResetButton
const STARS = preload("uid://dcfbync3s3iuw")

var first_gear_pos
var bell_pos

func _ready() -> void:
	time_left = time_target-time_passed
	start_button.pressed.connect(_on_start_button_pressed)
	reset_button.pressed.connect(_on_reset_pressed)
	ResetManager.register_function(reset_timer)
	label.text = get_converted_time(time_left)
	first_gear_pos = first_gear.position
	bell_pos = end_bell.position

func _on_reset_pressed():
	ResetManager.reset_components()

func reset_timer() -> void:
	time_passed = 0
	timer_running = false
	update_timer()

func start_timer() -> void:
	time_passed = 0
	timer_running = true
	GearChain.start_chain(first_gear)
	
func stop_timer() -> void:
	timer_running = false
	time_end = time_passed
	print("difference in time: " + str(abs(time_end-time_target)))
	
	var stars = 0
	if abs(time_end-time_target) >= 2:
		stars = 0
	elif abs(time_end-time_target) >= 1:
		stars = 1
	elif abs(time_end-time_target) >= 0.5:
		stars = 2
	else:
		stars = 3
		
	var star_inst = STARS.instantiate()
	star_inst.stars = stars
	star_inst.position = get_viewport_rect().size/2
	add_child(star_inst)

func _on_start_button_pressed():
	if !timer_running:
		start_timer()

func _process(delta: float) -> void:
	first_gear.position = first_gear_pos
	end_bell.position = bell_pos
	gnollar_indicator.text = "Gnollars: " + str(gnollars)
	if timer_running:
		update_timer(delta)

func update_timer(delta: float = 0) -> void:
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

#class_name kanonComponent
extends BaseComponent

var shoot_angle = 0
var shoot_dir = Vector2.ZERO
var shoot_str = 1000

@onready var kanon_pivot: Node2D = %Kanon_pivot
@onready var gnogel: GnogelProjectile = %Gnogel
@onready var kanon_sprite: AnimatedSprite2D = %Kanon_sprite
@onready var kanon_boom: AnimatedSprite2D = %kanon_boom
@onready var vlam_timer: Timer = %VlamTimer

@onready var gnogel_start_position: Vector2 = %Gnogel.position

func _ready():
	super()
	kanon_sprite.connect("animation_finished", _stop_lont)
	vlam_timer.timeout.connect(_on_vlam_timer_timeout)
	
func _stop_lont():
	print("stoplont")
	kanon_sprite.stop()
	kanon_boom.play("default")
	
func _find_connection(anchor: Node2D, direction: GlobalEnum.ComponentIODirection) -> BaseComponent:
	return null

func _process(_delta):
	#if Input.is_action_just_pressed("ui_accept"):
		#_on_vlam()

	if is_hovered and Input.is_action_just_pressed("right_click"):
		if Input.is_action_pressed("shift"):
			shoot_angle -= 0.1
		else:
			shoot_angle += 0.1
	
	kanon_pivot.rotation = shoot_angle	
	shoot_dir = Vector2.UP.rotated(shoot_angle)

	
	if gnogel.freeze:
		var kogel_pos = kanon_pivot.global_position +Vector2(10,0) + shoot_dir*160
		gnogel.global_position = kogel_pos
		gnogel.rotation = shoot_angle


func reset() -> void:
	super()
	gnogel.position = gnogel_start_position
	gnogel.disable()
	kanon_sprite.stop()
	kanon_boom.stop()
	vlam_timer.stop()


func _on_vlam():
	kanon_sprite.play("default")
	vlam_timer.start()
	
	
func _on_vlam_timer_timeout():
	gnogel.shoot(shoot_dir * shoot_str)
	$CustomAudioPlayer.play()


func _on_medium_gear_component_inventory_item_reached(_count) -> void:
	_on_vlam()
	print("vlam aan")

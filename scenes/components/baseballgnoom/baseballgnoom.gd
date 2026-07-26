extends BaseComponent
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var timer: Timer = $Timer
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var area_2d: Area2D = $Area2D
var is_activated : bool = false

func _ready():
	super()
	timer.timeout.connect(_on_timer_timeout)
	ResetManager.register_component(self)

func _on_timer_timeout():
	sprite_2d.play("default")

func start():
	timer.start()
	
func reset():
	timer.stop()
	sprite_2d.stop()
	sprite_2d.frame = 0

	
func _find_connection(anchor: Node2D, direction: GlobalEnum.ComponentIODirection) -> BaseComponent:
	return null

func _physics_process(_delta):
	if sprite_2d.frame == 3:
		collision_shape_2d.disabled = false
	else:
		collision_shape_2d.disabled = true

	if area_2d.get_overlapping_bodies():
		print(area_2d.get_overlapping_bodies())
		for item in area_2d.get_overlapping_bodies():
			if item.is_in_group("baseball"):
				print("het is een bal")
				if !item.get_parent().impulse_applied:
					item.apply_impulse(Vector2(10,-10)*100)
					item.get_parent().impulse_applied = true

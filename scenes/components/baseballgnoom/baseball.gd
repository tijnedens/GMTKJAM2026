extends BaseComponent

var impulse_applied = false
var is_activated : bool = false
var start_pos
@onready var rigid_body_2d: RigidBody2D = $RigidBody2D

func _ready():
	super()
	ResetManager.register_component(self)
	start_pos = position
	rigid_body_2d.freeze = true

func start():
	start_pos = position
	is_activated = true
	rigid_body_2d.freeze = false
	rigid_body_2d.gravity_scale = 1.0
	print(rigid_body_2d.position, rigid_body_2d.global_position)
	print(self.position, self.global_position)


	

func reset():
	
	rigid_body_2d.set_deferred("position", Vector2.ZERO)
	rigid_body_2d.freeze = true
	impulse_applied = false
	is_activated = false
	position = start_pos
	
	print(rigid_body_2d.position, rigid_body_2d.global_position)
	print(self.position, self.global_position)


func _physics_process(delta: float) -> void:
	

	var collision_info = move_and_collide(rigid_body_2d.linear_velocity * delta)
	if collision_info:
		if collision_info.get_collider().is_in_group("THEBELL"):
			collision_info.get_collider().get_parent()._on_hit()

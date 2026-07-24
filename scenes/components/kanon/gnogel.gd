extends RigidBody2D

var velocity = Vector2.ZERO

func _ready() -> void:
	freeze = true
	gravity_scale = 0

func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		if collision_info.get_collider().is_in_group("THEBELL"):
			collision_info.get_collider()._on_hit()

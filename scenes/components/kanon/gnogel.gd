class_name GnogelProjectile
extends RigidBody2D

var velocity = Vector2.ZERO

func _ready() -> void:
	disable()

func disable() -> void:
	freeze = true
	gravity_scale = 0.0

func enable() -> void:
	freeze = false
	gravity_scale = 1.0

func shoot(impulse: Vector2) -> void:
	enable()
	apply_impulse(impulse)

func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		if collision_info.get_collider().is_in_group("THEBELL"):
			collision_info.get_collider().get_parent()._on_hit()

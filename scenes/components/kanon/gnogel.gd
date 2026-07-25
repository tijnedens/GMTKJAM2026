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
	var collision_info: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision_info:
		var collider: CollisionObject2D = collision_info.get_collider()
		if collider is ProjectileCatcher:
			collider.on_hit()

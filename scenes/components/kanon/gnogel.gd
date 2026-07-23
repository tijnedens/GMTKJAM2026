extends RigidBody2D

var velocity = Vector2.ZERO

func _ready() -> void:
	freeze = true
	gravity_scale = 0

func _process(delta: float) -> void:
	pass	

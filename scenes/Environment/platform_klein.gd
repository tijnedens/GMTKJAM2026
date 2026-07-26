extends BaseComponent
@onready var static_body_2d: StaticBody2D = $StaticBody2D

func _find_connection(anchor: Node2D, direction: GlobalEnum.ComponentIODirection) -> BaseComponent:
	return null

func _on_mouse_shape_entered():
	is_hovered = true

func _on_mouse_shape_exited():
	is_hovered = false

func _process(_delta):
	#if Input.is_action_just_pressed("ui_accept"):
		#_on_vlam()

	if is_hovered and Input.is_action_just_pressed("right_click"):
		print("click")
		if Input.is_action_pressed("shift"):
			self.rotate(0.1*PI)
		else:
			self.rotate(-0.1*PI)
	

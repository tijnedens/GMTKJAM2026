extends GearComponent
@onready var area_2d: Area2D = $Hammer_Gear_pivot/Area2D

func _find_connection(anchor: Node2D, direction: GlobalEnum.ComponentIODirection) -> BaseComponent:
	return null

func _physics_process(delta: float) -> void:
	super(delta)
	var bodies = area_2d.get_overlapping_bodies()
	
	if bodies:
		print("tink")
		for body in bodies:

			if body.is_in_group("THEBELL"):
				print("bell")
				body.get_parent()._on_hit()

class_name GearComponent
extends BaseComponent

@export_enum("BIG", "MEDIUM", "SMALL") var gear_size = "MEDIUM"

var is_checked : bool = false
var rotation_speed : float = 1.0

var is_part_of_jammed_chain : bool = false
var next_gears : Array[GearComponent]
var activating_gears: Array[GearComponent]
@export var is_activated : bool = false
var activation_pulse_stop : bool = false

func _process(_delta):
	if next_gears.is_empty():
		$ConnectionArea/ConnectionShape.debug_color = Color.RED
	else:
		$ConnectionArea/ConnectionShape.debug_color = Color.GREEN
	
	if is_activated && !activation_pulse_stop:
		$BigGearVisualizer.visualize_start(40 * rotation_speed)
		print("start")
		activation_pulse_stop = true

func show_jam():
	$BigGearVisualizer.visualize_jam()

func start() -> void:
	pass

func reset() -> void:
	$BigGearVisualizer.reset()

func on_drop() -> void:
	pass

func on_pickup() -> void:
	pass

func _on_connection_area_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if area is Area2D and area.is_in_group("GearConnectionArea"):
		var gear_component : GearComponent = (area as Area2D).get_parent()
		if !next_gears.has(gear_component):
			next_gears.append(gear_component)


func _on_connection_area_area_shape_exited(_area_rid, area, _area_shape_index, _local_shape_index):
	if area is Area2D and area.is_in_group("GearConnectionArea"):
		var gear_component : GearComponent = (area as Area2D).get_parent()
		next_gears.erase(gear_component)
		gear_component.next_gears.erase(self)

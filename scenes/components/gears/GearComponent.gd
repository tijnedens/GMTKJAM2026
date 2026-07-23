class_name GearComponent
extends BaseComponent

@export_enum("BIG", "MEDIUM", "SMALL") var gear_size = "MEDIUM"
@export var inventory_item : Node
## Met de klok mee
@export_range(0, 360, 1.0, "radians_as_degrees")  var inventory_item_end_angle : float

signal inventory_item_reached

var is_checked : bool = false # used by GearChain class to check if this gear was already checked
var rotation_speed : float = 1.0

var next_gears : Array[GearComponent]
var is_activated : bool = false
var activation_pulse_stop : bool = false
var inventory_pulse_stop : bool = false

func _ready():
	if inventory_item:
		inventory_item.reparent($GearVisualizer/Sprite)

func _process(_delta):
	if next_gears.is_empty():
		$ConnectionArea/ConnectionShape.debug_color = Color.RED
	else:
		$ConnectionArea/ConnectionShape.debug_color = Color.GREEN
	
	if is_activated && !activation_pulse_stop:
		$GearVisualizer.visualize_start(20 * rotation_speed)
		activation_pulse_stop = true
	
	var current_animation_rotation : float = $GearVisualizer/Sprite.rotation
	if inventory_item && !inventory_pulse_stop && (roundf(current_animation_rotation * 10) == roundf(inventory_item_end_angle * 10)):
		inventory_item_reached.emit()
		inventory_pulse_stop = true

func show_jam():
	$GearVisualizer.visualize_jam()

func start() -> void:
	pass

func reset() -> void:
	$GearVisualizer.reset()

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

class_name GearComponent
extends BaseComponent

@export_enum("BIG", "MEDIUM", "SMALL") var gear_size = "MEDIUM"
@export var inventory_item : Node
## Met de klok mee
@export_range(0, 360, 1.0, "radians_as_degrees")  var inventory_item_end_angle : float
@export_range(0, 360, 1.0, "radians_as_degrees")  var inventory_item_start_angle : float

signal inventory_item_reached

var is_checked : bool = false # used by GearChain class to check if this gear was already checked
var rotation_speed : float = 1.0

var next_gears : Array[GearComponent]
var is_activated : bool = false
var activation_pulse_stop : bool = false
var inventory_pulse_stop : bool = false

static var current_dragged : GearComponent
var ghost_gear_sprite : CanvasItem = null
var stacked_gear : GearComponent = null

func _ready():
	super()
	if inventory_item:
		inventory_item.reparent($GearVisualizer/Sprite)
		inventory_item.rotation = inventory_item_start_angle
		

func _current_anim_rot_to_true_rotation():
	pass

func _process(_delta):
	if next_gears.is_empty():
		$ConnectionArea/ConnectionShape.debug_color = Color.RED
	else:
		$ConnectionArea/ConnectionShape.debug_color = Color.GREEN
	
	if is_activated && !activation_pulse_stop:
		$GearVisualizer.visualize_start(20 * rotation_speed)
		activation_pulse_stop = true
	
	var current_animation_rotation : float = fmod(($GearVisualizer/Sprite.rotation + inventory_item_start_angle),2*PI)

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
	print("pickup")
	current_dragged = self

func _input(event):
	if current_dragged && (current_dragged.gear_size == "MEDIUM" || current_dragged.gear_size == "SMALL"):
		if is_hovered && self.gear_size == "BIG" && !ghost_gear_sprite:
			var sprite : CanvasItem = current_dragged.get_node("GearVisualizer/Sprite")
			if sprite:
				ghost_gear_sprite = sprite.duplicate()
				ghost_gear_sprite.name = "GhostGear"
				ghost_gear_sprite.material = null
				ghost_gear_sprite.self_modulate.a = 0.2
				add_child(ghost_gear_sprite)
		elif !is_hovered && ghost_gear_sprite:
			remove_child(ghost_gear_sprite)
			ghost_gear_sprite = null
	
	if current_dragged && ghost_gear_sprite:
		if event is InputEventMouseButton && self.gear_size == "BIG":
			if is_hovered && !event.pressed && event.button_index == MOUSE_BUTTON_LEFT:
				stacked_gear = current_dragged
				stacked_gear.make_stacked(self)
				current_dragged = null
				remove_child(ghost_gear_sprite)
				ghost_gear_sprite = null
	
	super(event)

func make_stacked(parent_gear : GearComponent):
	collision_layer = 2
	collision_mask = 2
	global_position = parent_gear.global_position

func make_unstacked():
	collision_layer = 1
	collision_mask = 1

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

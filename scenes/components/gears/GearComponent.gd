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
static var current_stack_base_contender : GearComponent
var ghost_gear_sprite : CanvasItem = null
var stacked_gear : GearComponent = null
var base_gear : GearComponent = null

var default_z_index : int

func _ready():
	super()
	if inventory_item:
		inventory_item.reparent($GearVisualizer/Sprite)
		inventory_item.rotation = inventory_item_start_angle
	default_z_index = z_index
		

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
	#print("dragged: ", current_dragged)
	#print("contender: ", current_stack_base_contender)
	if self == current_dragged && current_stack_base_contender:
		var ghost = current_stack_base_contender.ghost_gear_sprite
		if ghost:
			ghost.queue_free()
			current_stack_base_contender.ghost_gear_sprite = null
			self.set_stacked(true, current_stack_base_contender)
	
	if stacked_gear && !no_collision:
		stacked_gear.set_move_collision(true)
	current_dragged = null

func on_pickup() -> void:
	current_dragged = self
	if stacked_gear:
		stacked_gear.set_move_collision(false)

func _physics_process(_delta):
	if base_gear:
		if base_gear.is_dragging:
			set_move_collision(false)
		elif !no_collision:
			set_move_collision(true)
		return
	
	if (is_dragging):
		var target = (get_global_mouse_position() - global_position - pin_delta)
		velocity = target.limit_length(drag_speed)
		set_move_collision(false)
	else: 
		velocity = Vector2.ZERO
		if !no_collision:
			set_move_collision(true)
	mouse_relative = Vector2.ZERO
	move_and_collide(velocity)

func _input(event):
	if disable_drag_drop || base_gear:
		return
	if current_dragged && (current_dragged.gear_size == "MEDIUM" || current_dragged.gear_size == "SMALL"):
		if is_hovered && self.gear_size == "BIG" && !ghost_gear_sprite && !stacked_gear:
			var sprite : CanvasItem = current_dragged.get_node("GearVisualizer/Sprite")
			if sprite:
				ghost_gear_sprite = sprite.duplicate()
				ghost_gear_sprite.name = "GhostGear"
				ghost_gear_sprite.material = null
				ghost_gear_sprite.self_modulate.a = 0.2
				add_child(ghost_gear_sprite)
				current_stack_base_contender = self
		elif !is_hovered && ghost_gear_sprite:
			remove_child(ghost_gear_sprite)
			ghost_gear_sprite = null
			current_stack_base_contender = null
	
	if event is InputEventMouseButton:
		if stacked_gear and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
			stacked_gear.set_stacked(false)
	
	if !base_gear:
		super(event)

func set_stacked(stacked : bool, parent_gear : GearComponent = null ):
	if stacked:
		reparent(parent_gear)
		global_position = parent_gear.global_position
		base_gear = parent_gear
	else:
		parent_gear = base_gear
		reparent(get_parent().get_parent())
		base_gear = null
	
	collision_layer = 1 << (8 - 1) if stacked else 1
	collision_mask = 0 if stacked else 1
	
	parent_gear.stacked_gear = self if stacked else null
	parent_gear.collision_layer = 1 << (2 - 1) if stacked else 1
	parent_gear.collision_mask = 1 << (1 - 1) | 1 << (2 - 1) if stacked else 1
	parent_gear.z_index = 0 if stacked else parent_gear.default_z_index
	disable_drag_drop = stacked
	current_stack_base_contender = null

func _on_connection_area_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if area is Area2D and area.is_in_group("GearConnectionArea"):
		var gear_component : GearComponent = (area as Area2D).get_parent()
		if !next_gears.has(gear_component):
			next_gears.append(gear_component)
		if (stacked_gear and gear_component.base_gear) or (base_gear and gear_component.stacked_gear):
			pass
		elif base_gear and base_gear.is_dragging:
			gear_component.next_gears.erase(base_gear)
			gear_component.collision_layer = 1 << (9 - 1)
			gear_component.collision_mask = 1 << (9 - 1) | 1 << (8 - 1) | 1
			base_gear.next_gears.erase(gear_component)
		elif is_dragging:
			if gear_component.base_gear:
				next_gears.erase(gear_component.base_gear)
				collision_layer = 1 << (9 - 1)
				collision_mask = 1 << (9 - 1) | 1 << (8 - 1) | 1
				gear_component.base_gear.next_gears.erase(self)
		


func _on_connection_area_area_shape_exited(_area_rid, area, _area_shape_index, _local_shape_index):
	if area is Area2D and area.is_in_group("GearConnectionArea"):
		var gear_component : GearComponent = (area as Area2D).get_parent()
		if is_dragging and gear_component.base_gear:
			next_gears.append(gear_component.base_gear)
			collision_layer = 1
			collision_mask = 1 << (2 - 1) | 1
		next_gears.erase(gear_component)
		gear_component.next_gears.erase(self)

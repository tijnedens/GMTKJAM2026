class_name KraanComponent
extends BaseComponent

var kraan_openheid : float = 0.0
var aantal_ticks_nodig : int = 4
@onready var ps = %ParticleSystem

func _find_connection(anchor: Node2D, direction: GlobalEnum.ComponentIODirection) -> BaseComponent:
	var space_state : PhysicsDirectSpaceState2D = get_world_2d().direct_space_state
	var origin : Vector2 = anchor.global_position
	var end : Vector2 = origin + ComponentConnector.io_direction_to_vector(direction) * 500
	var query : PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.create(origin, end)
	query.collide_with_areas = true
	var result : Dictionary = space_state.intersect_ray(query)
	if result:
		if result.collider != self and result.collider.is_in_group("WaterSink"):
			var found_component : WaterWheelComponent = result.collider.get_parent()
			if anchor.global_position.x < found_component.global_position.x:
				found_component.rotation_speed = -0.5
			else:
				found_component.rotation_speed = 0.5
			return found_component
	return null

func on_pickup() -> void:
	super()
	$CollisionShape2.disabled = true

func on_drop() -> void:
	super()
	$CollisionShape2.disabled = false

func reset() -> void:
	super()
	kraan_openheid = 0.0
	ps.amount_ratio = 0.0

func _on_small_gear_component_inventory_item_reached(count):
	if count > aantal_ticks_nodig:
		return
	if count == 1:
		ps.emitting = true
	ps.amount_ratio = count / float(aantal_ticks_nodig)
	ps.amount_ratio *= ps.amount_ratio
	if count == aantal_ticks_nodig && output_connection:
		var wheel = output_connection.to_component
		wheel.activate()

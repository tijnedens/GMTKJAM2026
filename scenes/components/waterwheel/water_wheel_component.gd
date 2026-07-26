class_name WaterWheelComponent
extends BaseComponent

var rotation_speed = 0.5

func _process(delta):
	$BigGearComponent.rotation_speed = self.rotation_speed
	$RotationAnchor.rotation = $BigGearComponent/GearVisualizer/Sprite.rotation

func _find_connection(anchor: Node2D, direction: GlobalEnum.ComponentIODirection) -> BaseComponent:
	var anchors = [anchor, $InputAnchor2]
	for a in anchors:
		var space_state : PhysicsDirectSpaceState2D = get_world_2d().direct_space_state
		var origin : Vector2 = a.global_position
		var end : Vector2 = origin + ComponentConnector.io_direction_to_vector(direction) * 500
		var query : PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.create(origin, end)
		query.collide_with_areas = true
		query.collision_mask = 1
		var result : Dictionary = space_state.intersect_ray(query)
		if result:
			if result.collider != self and result.collider.is_in_group("WaterEmitter"):
				var found_component : KraanComponent = result.collider.get_parent()
				if self.global_position.x > result.collider.global_position.x:
					rotation_speed = -0.5
				else:
					rotation_speed = 0.5
				return found_component
	return null

func activate():
	GearChain.start_chain($BigGearComponent)

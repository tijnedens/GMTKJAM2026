class_name ComponentConnector
extends Node

# Extract a normalized vector from a component IO direction
static func io_direction_to_vector(direction : GlobalEnum.ComponentIODirection) -> Vector2:
	match direction:
		GlobalEnum.ComponentIODirection.LEFT:
			return Vector2.LEFT
		GlobalEnum.ComponentIODirection.RIGHT:
			return Vector2.RIGHT
		GlobalEnum.ComponentIODirection.UP:
			return Vector2.UP
		GlobalEnum.ComponentIODirection.DOWN:
			return Vector2.DOWN
		_:
			return Vector2.ZERO

# Functie die een connection probeert te maken met een willekeurig andere component die geschikt is
# Er wordt rekening gehouden met de IO type van beide componenten
# from: de component die een connectie zoekt
static func find_connection(searching_component : BaseComponent) -> void:
	var from : BaseComponent = null
	var to : BaseComponent = null
	match searching_component.output_type:
		GlobalEnum.ComponentIOType.RANGED:
			from = searching_component._find_connection(searching_component.input_anchor, searching_component.input_direction)
			to = searching_component._find_connection(searching_component.output_anchor, searching_component.output_direction)
		_:
			pass
	if from:
		var input_connection = ComponentConnection.new(from, searching_component, searching_component.input_type)
		from.output_connection = input_connection
		searching_component.input_connection = input_connection
	elif searching_component.input_connection:
		searching_component.input_connection.from_component.output_connection = null
		searching_component.input_connection = null
	
	if to:
		var output_connection = ComponentConnection.new(searching_component, to, searching_component.output_type)
		to.input_connection = output_connection
		searching_component.output_connection = output_connection
	elif searching_component.output_connection:
		searching_component.output_connection.to_component.input_connection = null
		searching_component.output_connection = null

class_name ComponentConnection
extends Node

var from_component : BaseComponent
var to_component : BaseComponent

var connection_type : GlobalEnum.ComponentIOType

func _init(from : BaseComponent, to : BaseComponent, connection_type : GlobalEnum.ComponentIOType):
	self.from_component = from
	self.to_component = to
	self.connection_type = connection_type

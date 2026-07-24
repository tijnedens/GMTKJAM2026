class_name ResetManagerClass
extends Node

signal reset_signal

func reset_components() -> void:
	reset_signal.emit()

func register_component(component: BaseComponent) -> void:
	reset_signal.connect(component.reset)

func register_function(callable: Callable) -> void:
	reset_signal.connect(callable)

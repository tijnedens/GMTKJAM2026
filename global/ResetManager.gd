class_name ResetManagerClass
extends Node

signal reset_signal
signal start_signal

func reset_components() -> void:
	reset_signal.emit()

func start_components() -> void:
	start_signal.emit()

func register_component(component: BaseComponent) -> void:
	reset_signal.connect(component.reset)
	start_signal.connect(component.start)

func register_function(callable: Callable) -> void:
	reset_signal.connect(callable)

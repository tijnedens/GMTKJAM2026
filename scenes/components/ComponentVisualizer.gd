@icon("res://assets/images/editor_icons/eye.svg")
@abstract class_name ComponentVisualizer
extends Node2D

@abstract func visualize_start(gear_speed: float) -> void
@abstract func visualize_jam() -> void
@abstract func reset() -> void

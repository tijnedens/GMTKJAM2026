class_name ProjectileCatcher
extends StaticBody2D

signal hit_by_projectile

func on_hit() -> void:
	hit_by_projectile.emit()
	print("bop")
	_on_hit()

## overwrite function where necessary
func _on_hit() -> void:
	pass

class_name ZandLoper
extends BaseComponent

@onready var anim_player: AnimationPlayer = %AnimationPlayer
@onready var output_gear: GearComponent = %OutputGear

func flip_zandloper() -> void:
	anim_player.play("start_countdown")

func _on_projectile_caught() -> void:
	flip_zandloper()

func reset() -> void:
	idle_anim()

func idle_anim() -> void:
	anim_player.play("idle")

func sand_running_finished() -> void:
	idle_anim()
	GearChain.start_chain(output_gear)
	

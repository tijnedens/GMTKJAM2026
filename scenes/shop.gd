extends CenterContainer

@onready var button_big_gear: Button = $container/ScrollContainer/MarginContainer/GridContainer/button_big_gear
@onready var button_mid_gear: Button = $container/ScrollContainer/MarginContainer/GridContainer/button_mid_gear
@onready var button_small_gear: Button = $container/ScrollContainer/MarginContainer/GridContainer/button_small_gear

func _ready():
	button_big_gear.pressed.connect(_on_big_gear_buy)
	button_mid_gear.pressed.connect(_on_mid_gear_buy)
	button_small_gear.pressed.connect(_on_small_gear_buy)

func _on_big_gear_buy():
	#TODO instantiate big gear 
	pass
	
func _on_mid_gear_buy():
	#TODO instantiate mid gear
	pass
	
func _on_small_gear_buy():
	#TODO instantiate small gear
	pass

func _process(delta: float) -> void:
	#open menu when pressing tab
	if Input.is_action_pressed("open_menu"):
		visible = true
	else:
		visible = false

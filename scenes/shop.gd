extends CenterContainer

@onready var button_big_gear: Button = $container/ScrollContainer/MarginContainer/GridContainer/ButtonBigGear
@onready var button_mid_gear: Button = $container/ScrollContainer/MarginContainer/GridContainer/ButtonMidGear
@onready var button_small_gear: Button = $container/ScrollContainer/MarginContainer/GridContainer/ButtonSmallGear
@onready var button_kannon: Button = $container/ScrollContainer/MarginContainer/GridContainer/ButtonKannon

const BIG_GEAR_COMPONENT = preload("uid://cfkc3vjob3gm0")
const MEDIUM_GEAR_COMPONENT = preload("uid://dbn6ymfsdljgu")
const SMALL_GEAR_COMPONENT = preload("uid://bjknbkgpoppmi")
const KANON = preload("uid://br5r705ueiobe")


func _ready():
	
	button_big_gear.pressed.connect(_on_big_gear_buy)
	button_mid_gear.pressed.connect(_on_mid_gear_buy)
	button_small_gear.pressed.connect(_on_small_gear_buy)
	button_kannon.pressed.connect(_on_kanon_gear_buy)

func _on_big_gear_buy():
	if get_parent().gnollars >= 100:
		get_parent().gnollars -= 100
		var inst = BIG_GEAR_COMPONENT.instantiate()
		inst.position = get_global_mouse_position()
		get_parent().add_child(inst)
	
	
func _on_mid_gear_buy():
	if get_parent().gnollars >= 100:
		get_parent().gnollars -= 100
		var inst = MEDIUM_GEAR_COMPONENT.instantiate()
		inst.position = get_global_mouse_position()
		get_parent().add_child(inst)
	
func _on_small_gear_buy():
	if get_parent().gnollars >= 100:
		get_parent().gnollars -= 100
		var inst = SMALL_GEAR_COMPONENT.instantiate()
		inst.position = get_global_mouse_position()
		get_parent().add_child(inst)

func _on_kanon_gear_buy():
	if get_parent().gnollars >= 100:
		get_parent().gnollars -= 100
		var inst = KANON.instantiate()
		inst.position = get_global_mouse_position()
		get_parent().add_child(inst)


func _process(delta: float) -> void:
	#open menu when pressing tab
	if Input.is_action_pressed("open_menu"):
		visible = true
	else:
		visible = false

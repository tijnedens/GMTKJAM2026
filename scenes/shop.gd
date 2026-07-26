extends CenterContainer


@onready var button_big_gear: Button = $container/ScrollContainer/MarginContainer/GridContainer/ButtonBigGear
@onready var button_mid_gear: Button = $container/ScrollContainer/MarginContainer/GridContainer/ButtonMidGear
@onready var button_small_gear: Button = $container/ScrollContainer/MarginContainer/GridContainer/ButtonSmallGear
@onready var button_kannon: Button = $container/ScrollContainer/MarginContainer/GridContainer/ButtonKannon
@onready var button_bounce_pad: Button = $container/ScrollContainer/MarginContainer/GridContainer/ButtonBouncePad
@onready var button_hammer_medium: Button = $container/ScrollContainer/MarginContainer/GridContainer/ButtonHammerMedium
@onready var button_kraan: Button = $container/ScrollContainer/MarginContainer/GridContainer/ButtonKraan
@onready var button_water_wheel: Button = $container/ScrollContainer/MarginContainer/GridContainer/ButtonWaterWheel

const BIG_GEAR_COMPONENT = preload("uid://cfkc3vjob3gm0")
const MEDIUM_GEAR_COMPONENT = preload("uid://dbn6ymfsdljgu")
const SMALL_GEAR_COMPONENT = preload("uid://bjknbkgpoppmi")
const KANON = preload("uid://br5r705ueiobe")
const PLATFORM_KLEIN_BOUNCE = preload("uid://qs4f1oosmr1y")
const NOP = preload("uid://d12mytyfecqty")
const HAMMER_GEAR = preload("uid://bk3703qewpvr7")
const KRAAN_COMPONENT = preload("uid://db2l5c8kes7q4")
const WATER_WHEEL_COMPONENT = preload("uid://ctr7slwhew02r")

@export var button_big_gear_disabled : bool
@export var button_mid_gear_disabled : bool
@export var button_small_gear_disabled : bool
@export var button_kannon_disabled : bool
@export var button_bounce_pad_disabled : bool
@export var button_gear_hammer_mid_disabled : bool
@export var button_kraan_disabled : bool
@export var button_water_wheel_disabled : bool

func _ready():
	
	button_big_gear.pressed.connect(_on_big_gear_buy)
	button_mid_gear.pressed.connect(_on_mid_gear_buy)
	button_small_gear.pressed.connect(_on_small_gear_buy)
	button_kannon.pressed.connect(_on_kanon_gear_buy)
	button_bounce_pad.pressed.connect(_on_bounce_buy)
	button_hammer_medium.pressed.connect(_on_hammer_buy)
	button_kraan.pressed.connect(_on_kraan_buy)
	button_water_wheel.pressed.connect(_on_water_wheel_buy)

	
	if button_big_gear_disabled:
		button_big_gear.icon = NOP
		
	if button_mid_gear_disabled:
		button_mid_gear.icon = NOP
		
	if button_small_gear_disabled:
		button_small_gear.icon = NOP
		
	if button_kannon_disabled:
		button_kannon.icon = NOP
		
	if button_bounce_pad_disabled:
		button_bounce_pad.icon = NOP
		
	if button_gear_hammer_mid_disabled:
		button_hammer_medium.icon = NOP
	
	if button_kraan_disabled:
		button_kraan.icon = NOP
	
	if button_water_wheel_disabled:
		button_water_wheel.icon = NOP

func _on_hammer_buy():
	if get_parent().gnollars >= 100 and !button_gear_hammer_mid_disabled:
		get_parent().gnollars -= 100
		var inst = HAMMER_GEAR.instantiate()
		inst.position = get_global_mouse_position()
		get_parent().add_child(inst)

func _on_bounce_buy():
	if get_parent().gnollars >= 100 and !button_bounce_pad_disabled:
		get_parent().gnollars -= 100
		var inst = PLATFORM_KLEIN_BOUNCE.instantiate()
		inst.position = get_global_mouse_position()
		get_parent().add_child(inst)

func _on_big_gear_buy() :
	if get_parent().gnollars >= 100 and !button_big_gear_disabled:
		get_parent().gnollars -= 100
		var inst = BIG_GEAR_COMPONENT.instantiate()
		inst.position = get_global_mouse_position()
		get_parent().add_child(inst)
	
	
func _on_mid_gear_buy() :
	if get_parent().gnollars >= 100 and !button_mid_gear_disabled:
		get_parent().gnollars -= 100
		var inst = MEDIUM_GEAR_COMPONENT.instantiate()
		inst.position = get_global_mouse_position()
		get_parent().add_child(inst)
	
func _on_small_gear_buy():
	if get_parent().gnollars >= 100 and !button_small_gear_disabled:
		get_parent().gnollars -= 100
		var inst = SMALL_GEAR_COMPONENT.instantiate()
		inst.position = get_global_mouse_position()
		get_parent().add_child(inst)

func _on_kanon_gear_buy():
	if get_parent().gnollars >= 100 and !button_kannon_disabled:
		get_parent().gnollars -= 100
		var inst = KANON.instantiate()
		inst.position = get_global_mouse_position()
		get_parent().add_child(inst)

func _on_kraan_buy():
	if get_parent().gnollars >= 100 and !button_kraan_disabled:
		get_parent().gnollars -= 100
		var inst = KRAAN_COMPONENT.instantiate()
		inst.position = get_global_mouse_position()
		get_parent().add_child(inst)

func _on_water_wheel_buy():
	if get_parent().gnollars >= 100 and !button_water_wheel_disabled:
		get_parent().gnollars -= 100
		var inst = WATER_WHEEL_COMPONENT.instantiate()
		inst.position = get_global_mouse_position()
		get_parent().add_child(inst)


func _process(delta: float) -> void:
	#open menu when pressing tab
	if Input.is_action_pressed("open_menu"):
		visible = true
	else:
		visible = false

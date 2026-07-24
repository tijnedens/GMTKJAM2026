extends Node2D

var stars = 0
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

func  _ready():
	sprite_2d.frame = stars

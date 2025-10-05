class_name PlayerHitBox
extends Area2D

@export var damage: int = 1
@onready var anim = $"../AnimatedSprite2D"

func _ready():
	monitoring = true

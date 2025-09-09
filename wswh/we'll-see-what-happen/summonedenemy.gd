extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $summoned_enemy
@export var health: int = 30

func _ready():
	anim.play("walk")


func take_damage(amount: int):
	health -= amount
	if health <= 0:
		die()

func die():
	print("dead minion")
	queue_free()

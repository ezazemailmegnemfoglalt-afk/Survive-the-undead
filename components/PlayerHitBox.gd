class_name PlayerHitBox
extends Area2D

@export var damage: int = 1

func _ready():
	monitoring = true		
	
func _on_area_entered(area: Area2D):
	if area is Sword:
		damage += 10

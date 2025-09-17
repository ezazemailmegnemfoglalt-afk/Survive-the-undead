class_name Sword
extends Area2D

func _on_area_entered(area: Area2D):
	if area is PlayerHitBox:
		print("Damage +10!")
		queue_free()

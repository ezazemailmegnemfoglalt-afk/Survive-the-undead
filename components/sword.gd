class_name Sword
extends Area2D

func _on_area_entered(area: Area2D):
	if area is PlayerHitBox:
		print("Damage +10!")
		
		# Increase the damage
		area.damage += 10
		
		# Notify UIManager about the damage change
		var game_manager = get_node("/root/GameManager")
		if game_manager:
			game_manager.emit_signal("player_damage_changed", area.damage)
		
		queue_free()

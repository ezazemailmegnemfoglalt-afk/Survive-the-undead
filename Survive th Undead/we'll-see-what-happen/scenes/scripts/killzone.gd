extends Area2D


func deal_damage(target):
	if target.has_method("take_damage"):
		target.deal_damage(25)
	

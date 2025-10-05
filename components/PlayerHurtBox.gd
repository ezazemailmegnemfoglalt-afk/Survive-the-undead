class_name PlayerHurtBox
extends Area2D

func _ready():
	connect("area_entered", _on_area_entered)

func _on_area_entered(area: Area2D):
	if area is EnemyHitBox and area.monitoring:
		var game_manager = get_node("/root/GameManager")
		if game_manager and game_manager.is_player_alive():
			print("Player hit by enemy!")
			game_manager.take_damage(area.damage)

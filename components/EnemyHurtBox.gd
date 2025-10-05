class_name EnemyHurtBox
extends Area2D

@export var score_value: int = 10
@export var health: Health  

 
func _ready():
	connect("area_entered", _on_area_entered)
	if health:
		health.health_depleted.connect(_on_enemy_died)

func _on_area_entered(area: Area2D):
	if area is PlayerHitBox and area.monitoring:
		pass

func _on_enemy_died():
	var game_manager = get_node("/root/GameManager")
	if game_manager:
		game_manager.add_score(score_value)
		print("Enemy killed! +", score_value, " points")
	get_parent().queue_free()

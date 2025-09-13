extends CharacterBody2D

@export var health: int = 3
@export var summon_scene: PackedScene

func summon():
	await get_tree().create_timer(2.0).timeout
	if summon_scene:
		for i in range(3):
			var s = summon_scene.instantiate()
			s.global_position = global_position + Vector2(50, 0) 
			get_tree().current_scene.add_child(s)



func _on_health_health_depleted() -> void:
	queue_free()

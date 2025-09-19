extends Node2D
@export var enemy_scene: PackedScene
@export var spawn_position: Node2D  
var has_triggered := false



@onready var timer: Timer = $AttackTimer


func _on_timer_timeout():
	timer.start(1.0)
	_spawn_enemy()


func _spawn_enemy():
	for i in range(10):
		var enemy = enemy_scene.instantiate()
		if spawn_position:
			enemy.global_position = spawn_position.global_position
		else:
			enemy.global_position = global_position
		get_tree().current_scene.add_child(enemy)

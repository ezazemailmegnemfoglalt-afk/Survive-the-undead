extends Area2D
@export var enemy_scene: PackedScene
@export var spawn_position: Node2D  
var has_triggered := false

func _ready():
	connect("body_entered", _on_body_entered)

func _on_body_entered(body: Node):
	if has_triggered:
		return
	if body.is_in_group("players") and enemy_scene:
		has_triggered = true
		_spawn_enemy()

func _spawn_enemy():
	var enemy = enemy_scene.instantiate()
	if spawn_position:
		enemy.global_position = spawn_position.global_position
	else:
		enemy.global_position = global_position
	get_tree().current_scene.add_child(enemy)

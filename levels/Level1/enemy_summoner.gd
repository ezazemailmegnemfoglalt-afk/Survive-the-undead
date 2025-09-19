extends Node2D

@export var sword_scene: PackedScene
@export var spawnn_interval: float = 5.0
@export var summon_scene: PackedScene
@export var spawn_interval: float = 5.0
@export var enemy_count: int = 10

@onready var swspawn := $Node2D
@onready var spawns := [$Spawn1, $Spawn2]
@onready var timer := Timer.new()

func _ready():
	randomize()
	add_child(timer)
	timer.wait_time = spawn_interval
	timer.one_shot = false
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

func _sw_timer():
	randomize()
	add_child(timer)
	timer.wait_time = spawnn_interval
	timer.one_shot = false
	timer.timeout.connect(_onn_timer_timeout)
	timer.start()

func _onn_timer_timeout():
	summon_sword()

func summon_sword():
	if summon_scene:
		var s = summon_scene.instantiate()
		s.global_position = global_position + Vector2(50, 0)
		get_tree().current_scene.add_child(s)


func _on_timer_timeout():
	summon_wave()

func summon_wave():
	if spawns.is_empty():
		return

	var chosen_spawn: Node2D = spawns.pick_random()
	print("Hullám innen:", chosen_spawn.name)

	for i in range(enemy_count):
		var s = summon_scene.instantiate()
		s.global_position = chosen_spawn.global_position + Vector2(50 * i, 0)
		get_tree().current_scene.add_child(s)

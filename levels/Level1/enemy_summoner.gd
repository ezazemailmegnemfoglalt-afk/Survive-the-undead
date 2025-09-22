extends Node2D

@export var sword_scene: PackedScene    
@export var spawnn_interval: float = 20.0  
@export var summon_scene: PackedScene       
@export var spawn_interval: float = 5.0     
@export var enemy_count: int = 10           

@onready var swspawn := $Node2D             
@onready var spawns := [$Spawn1, $Spawn2]    

@onready var enemy_timer := Timer.new()
@onready var sword_timer := Timer.new()

func _ready():
	randomize()

	add_child(enemy_timer)
	enemy_timer.wait_time = spawn_interval
	enemy_timer.one_shot = false
	enemy_timer.timeout.connect(_on_enemy_timer_timeout)
	enemy_timer.start()

	add_child(sword_timer)
	sword_timer.wait_time = spawnn_interval
	sword_timer.one_shot = true
	sword_timer.timeout.connect(_on_sword_timer_timeout)
	sword_timer.start()

func _on_enemy_timer_timeout():
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

func _on_sword_timer_timeout():
	summon_sword()

func summon_sword():
	if sword_scene:
		var s = sword_scene.instantiate()
		s.global_position = swspawn.global_position
		get_tree().current_scene.add_child(s)
		print("Kard spawnolt itt:", swspawn.name)

extends Node2D

@export var sword_scene: PackedScene    
@export var sword_interval: float = 2.0  
@export var summon_scene: PackedScene       
@export var spawn_interval: float = 20     
@export var enemy_count: int = 10           

@onready var spawn1 := $Spawn1          
@onready var spawn2 := $Spawn2 
@onready var enemy_timer := Timer.new()
@onready var sword_timer := Timer.new()

func _ready():
	add_child(sword_timer)
	sword_timer.wait_time = sword_interval
	sword_timer.one_shot = true
	sword_timer.timeout.connect(_summon_sword)
	sword_timer.start()
	print("Kard ennyi sec múlva: ")
	
	add_child(enemy_timer)
	enemy_timer.wait_time = spawn_interval
	enemy_timer.one_shot = false
	enemy_timer.timeout.connect(_summon_enemy)
	enemy_timer.start()
	print("enemy ennyi sec múlva: ")
	

func _summon_sword(): 
	var s = sword_scene.instantiate() 
	s.global_position = spawn1.global_position
	get_tree().current_scene.add_child(s)
	print("Kardoskút")

func _summon_enemy():
	if summon_scene: 
		var s = summon_scene.instantiate() 
		s.global_position = spawn2.global_position
		get_tree().current_scene.add_child(s)
		print("enemyskút")

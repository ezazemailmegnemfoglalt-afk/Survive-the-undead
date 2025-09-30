extends Node2D

@export var main_menu_scene: PackedScene
@export var delay: float = 33.0

@onready var timer := Timer.new()

func _ready():
	add_child(timer)
	timer.wait_time = delay
	timer.one_shot = true         # csak egyszer fusson le
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

func _on_timer_timeout():
	if main_menu_scene:
		get_tree().change_scene_to_packed(main_menu_scene)
		print("Átváltottunk a főmenüre!")

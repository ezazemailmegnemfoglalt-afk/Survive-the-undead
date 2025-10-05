extends Control

@onready var retry_btn = $Panel/Retry/Button
@onready var exit_btn   = $Panel/Exit/Button2

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS   
	visible = false

	retry_btn.pressed.connect(_on_retry_pressed)
	exit_btn.pressed.connect(_on_exit_pressed)

func _on_retry_pressed():
	var game_manager = get_node("/root/GameManager")
	if game_manager:
		game_manager.reset_game()
	get_tree().reload_current_scene()
	
	
func _on_exit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menu/MainMenu.tscn")

extends Control

@onready var resume_btn = $Panel/Resume/Button
@onready var exit_btn   = $Panel/Exit/Button2

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS   
	visible = false

	resume_btn.pressed.connect(_on_resume_pressed)
	exit_btn.pressed.connect(_on_exit_pressed)

func _input(event):
	if event.is_action_pressed("Pause"):
		if get_tree().paused:
			_resume_game()
		else:
			_pause_game()
				
func _pause_game():
	visible = true
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) 

func _resume_game():
	visible = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_resume_pressed():
	_resume_game()

func _on_exit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menu/MainMenu.tscn")

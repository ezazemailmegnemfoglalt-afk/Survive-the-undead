extends Node2D

@onready var pause_menu: Control = $Player/Camera2D/PauseMenu

func _input(event):
	if event.is_action_pressed("Pause"):
		if get_tree().paused:
			_resume_game()
		else:
			_pause_game()
			if event.is_action_pressed("Pause"):
				_resume_game()
				
func _pause_game():
	get_tree().paused = true
	pause_menu.visible = true
		
func _resume_game():
	get_tree().paused = false
	pause_menu.visible = false

extends Control

@onready var level2_btn = $ButtonContainer4/Button4
@onready var level1_btn = $ButtonContainer/Button

func _ready():
	#$ButtonContainer/Button.pressed.connect(func(): _load_level("res://levels/Level1/level_1.tscn"))
	#$ButtonContainer2/Button2.pressed.connect(func(): _load_level("res://levels/Level2.tscn"))
	#$ButtonContainer3/Button3.pressed.connect(func(): _load_level("res://levels/Level3.tscn"))
	#$ButtonContainer4/Button4.pressed.connect(func(): _load_level("res://levels/Level4/Level4.tres.tscn"))
	#$ButtonContainer5/Button5.pressed.connect(func(): _load_level("res://levels/Level5.tscn"))
	#$ButtonContainer5/Button5.pressed.connect(func(): _load_level("res://levels/Level5.tscn"))
	#$ButtonContainer5/Button5.pressed.connect(func(): _load_level("res://levels/Level5.tscn"))

	level1_btn.pressed.connect(_on_level1_pressed)
	level2_btn.pressed.connect(_on_level2_pressed)

func _on_level1_pressed():
	GameManager.reset_health()
	GameManager.reset_score()
	get_tree().change_scene_to_file("res://lvl1remaster.tscn")
	
	
func _on_level2_pressed():
	GameManager.reset_health()
	GameManager.reset_score()
	get_tree().change_scene_to_file("res://levels/Level4/Level4.tres.tscn")

extends Control

func _ready():
	$ButtonContainer/Button.pressed.connect(func(): _load_level("res://levels/Level1/Level_1.tscn"))
	#$ButtonContainer2/Button2.pressed.connect(func(): _load_level("res://levels/Level2.tscn"))
	#$ButtonContainer3/Button3.pressed.connect(func(): _load_level("res://levels/Level3.tscn"))
	$ButtonContainer4/Button4.pressed.connect(func(): _load_level("res://levels/Level4/Level4.tres.tscn"))
	#$ButtonContainer5/Button5.pressed.connect(func(): _load_level("res://levels/Level5.tscn"))


func _load_level(path: String):
	var level = load(path)
	get_tree().change_scene_to_packed(level)

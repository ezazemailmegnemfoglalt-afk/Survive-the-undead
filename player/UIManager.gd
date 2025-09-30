class_name UIManager
extends CanvasLayer

@export var health_label: Label
@export var health_value: Label
@export var score_label: Label
@export var score_value: Label
@export var damage_label: Label
@export var damage_value: Label
@export var end_menu_bad: Control  # Add this export for EndMenuBad

var game_manager: GameManager
var player_hitbox: PlayerHitBox

func _ready():
	# Get GameManager
	game_manager = get_node("/root/GameManager")
	
	# Find player hitbox
	_find_player_hitbox()
	
	# Connect signals
	if game_manager:
		game_manager.health_changed.connect(_on_health_changed)
		game_manager.score_changed.connect(_on_score_changed)
		game_manager.player_damaged.connect(_on_player_damaged)
		game_manager.player_died.connect(_on_player_died)
		# ADD THIS NEW CONNECTION
		game_manager.player_damage_changed.connect(_on_player_damage_changed)
	
	# Hide end menu at start
	if end_menu_bad:
		end_menu_bad.visible = false
		print("UIManager: EndMenuBad hidden at start")
	
	# Initial update
	update_all_displays()

func _on_player_damage_changed(new_damage: int):
	print("UIManager: Damage changed signal received: ", new_damage)
	damage_value.text = str(new_damage)


func _find_player_hitbox():
	# Camera2D -> Player -> Look for PlayerHitBox
	var camera = get_parent() as Camera2D
	if camera:
		var player = camera.get_parent()
		for child in player.get_children():
			if child is PlayerHitBox:
				player_hitbox = child
				print("UIManager: Found PlayerHitBox")
				break
	
	# Start damage polling
	if player_hitbox:
		_start_damage_polling()

func _start_damage_polling():
	var current_damage = player_hitbox.damage if player_hitbox else 1
	
	while true:
		await get_tree().create_timer(0.3).timeout
		if player_hitbox and player_hitbox.damage != current_damage:
			current_damage = player_hitbox.damage
			update_damage_display()

func update_all_displays():
	update_health_display()
	update_score_display()
	update_damage_display()

func update_health_display():
	if game_manager:
		var health = game_manager.get_health()
		var max_health = game_manager.get_max_health()
		health_value.text = "%d/%d" % [health, max_health]
		
		# Color coding
		var health_percent = game_manager.get_health_percentage()
		if health_percent < 0.3:
			health_value.modulate = Color.RED
		elif health_percent < 0.6:
			health_value.modulate = Color.YELLOW
		else:
			health_value.modulate = Color.WHITE

func update_score_display():
	if game_manager:
		score_value.text = str(game_manager.get_score())  # This will work now
	else:
		score_value.text = "0"

func update_damage_display():
	if player_hitbox:
		damage_value.text = str(player_hitbox.damage)

func _on_health_changed():
	update_health_display()

func _on_score_changed(new_score: int):
	update_score_display()

func _on_player_damaged(damage: int):
	print("UI: Player took ", damage, " damage")

func _on_player_died():
	update_health_display()
	
	# Show the end menu
	if end_menu_bad:
		end_menu_bad.visible = true
		print("UIManager: EndMenuBad made visible!")
	else:
		print("UIManager: EndMenuBad not found!")

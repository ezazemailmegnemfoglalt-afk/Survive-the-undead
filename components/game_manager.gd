extends Node

var score: int = 0
var health: int = 500
var max_health: int = 500
var is_alive: bool = true

signal player_died()
signal health_changed()
signal score_changed(new_score: int)
signal player_damaged(damage: int)
signal player_damage_changed(new_damage: int)
signal game_reset()

func _ready():
	print("GameManager ready - Health: ", health, "/", max_health)
	health = max_health
	reset_game()  # Reset on startup


# Call this when scene reloads
func _on_scene_reloaded():
	reset_game()

func reset_game():
	health = max_health
	score = 0
	is_alive = true
	print("Game reset - Health: ", health, "/", max_health, " | Score: ", score)
	health_changed.emit()
	score_changed.emit(score)
	game_reset.emit()
	
	
func take_damage(damage_amount: int = 1) -> void:
	if not is_alive:
		return
	
	health -= damage_amount
	health = max(0, health)  # Don't go below 0
	print("Took damage: ", damage_amount, " | Health: ", health, "/", max_health)
	
	player_damaged.emit(damage_amount)
	health_changed.emit()
	
	if health <= 0:
		health = 0
		is_alive = false
		print("PLAYER DIED - Emitting death signal")
		player_died.emit()


func heal(heal_amount: int = 1) -> void:
	health += heal_amount
	health = min(health, max_health)
	health_changed.emit()

func add_score(points: int = 1) -> void:
	score += points
	print("Pontszám:", score)
	score_changed.emit(score)

func reset_score() -> void:
	score = 0
	score_changed.emit(score)

func reset_health() -> void:
	health = max_health
	is_alive = true
	health_changed.emit()

func get_health() -> int:
	return health

func get_max_health() -> int:
	return max_health

func get_health_percentage() -> float:
	return float(health) / float(max_health)

func is_player_alive() -> bool:
	return is_alive and health > 0

# ADD THIS MISSING FUNCTION:
func get_score() -> int:
	return score

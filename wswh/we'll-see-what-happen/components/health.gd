class_name Health
extends Node

signal max_health_changed(diff: int)
signal health_changed(diff: int)
signal health_depleted

@export var max_health: int = 3 : set = set_max_health, get = get_max_health
@export var immortality: bool = false : set = set_immortality, get = get_immortality
@onready var health: int = max_health : set = set_health, get = get_health
var immortality_timer: Timer = null

func set_max_health(value: int):
	var clamped = max(1, value)
	if clamped != max_health:
		var diff = clamped - max_health
		max_health = clamped	
		max_health_changed.emit(diff)
		if health > max_health:
			set_health(max_health)

func get_max_health() -> int:
	return max_health

func set_immortality(value: bool):
	immortality = value

func get_immortality() -> bool:
	return immortality

func set_temporary_immortality(time: float):
	if immortality_timer == null:
		immortality_timer = Timer.new()
		immortality_timer.one_shot = true
		add_child(immortality_timer)
	immortality_timer.timeout.connect(set_immortality.bind(false))
	immortality = true
	immortality_timer.start(time)

func set_health(value: int):
	if value < health and immortality:
		return
	var clamped = clampi(value, 0, max_health)
	if clamped != health:
		var diff = clamped - health
		health = clamped
		health_changed.emit(diff)
		if health == 0:
			health_depleted.emit()

func get_health() -> int:
	return health

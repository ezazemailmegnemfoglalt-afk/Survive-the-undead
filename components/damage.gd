class_name Damage
extends Node

@export var damage: int = 1 : set = set_damage, get = get_damage

func set_damage(value: int):
	damage = max(0, value)

func get_damage() -> int:
	return damage

extends CharacterBody2D

@export var speed: float = 80.0

var target: Node = null

func _on_health_health_depleted() -> void:
	queue_free()
	print("enemy meghalt a faszba.")

func _ready() -> void:
	target = get_tree().get_first_node_in_group("players")

func _physics_process(delta: float) -> void:
	if target:
		var dir = (target.global_position - global_position).normalized()
		velocity = dir * speed
		move_and_slide()

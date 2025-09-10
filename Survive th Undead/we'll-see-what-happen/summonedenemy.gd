extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $summoned_enemy
@export var health: int = 30
@export var damage: int = 100
@export var speed: float = 30.0
@export var patrol_distance: float = 200.0

var target: Node = null
var start_position: Vector2
var direction: int = 1


func _ready():
	anim.play("walk")
	start_position = global_position
	target = get_tree().get_first_node_in_group("players")
	
	

func _physics_process(delta):
	if target:
		var dir = (target.global_position - global_position).normalized()
		velocity = dir * speed
		move_and_slide()

func take_damage(amount: int):
	health -= amount
	if health <= 0:
		die()

func die():
	print("dead minion")
	queue_free()


func _on_hitbox_body_entered(body):
	if body.is_in_group("players"):
		if body.has_method("take_damage"):
			body.take_damage(damage)
			print("the enemy have hurted you!" )

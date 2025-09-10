extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@export var summon_scene: PackedScene
@export var health: int = 15
@export var summon_interval: float = 5.0
@export var damage: int = 20

@onready var timer: Timer = $Timer


func _ready():
	anim.play("default")
	timer.wait_time = summon_interval
	timer.start()
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	summon()


func summon():
	for i in range(3):
		if summon_scene:
			var minion = summon_scene.instantiate()
			minion.global_position = global_position + Vector2(randi_range(-50, 50), randi_range(-50, 50))
			get_tree().current_scene.add_child(minion)
			print("Minion summoned!")
		

func take_damage(amount: int):
	health -= amount
	if health <= 0:
		die()

func die():
	print("summoner dead!")
	queue_free()


func _on_hitbox_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
		print("the enemy have hurted you!" )

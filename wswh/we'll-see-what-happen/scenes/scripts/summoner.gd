extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@export var summon_scene: PackedScene
@export var health: int = 115
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
	
func _on_Hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("hitbox"):
		var parent = area.get_parent()
		if parent.has_method("deal_damage"):
			parent.deal_damage(self)


func deal_damage(target: Node):
	if target.has_method("take_damage"):
		target.take_damage(damage)

func take_damage(amount: int):
	health -= amount
	print("summoner kapott:", amount, "| élet:", health)
	if health <= 0:
		die()

func die():
	queue_free()

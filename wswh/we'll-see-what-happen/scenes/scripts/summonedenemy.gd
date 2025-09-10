extends CharacterBody2D

@export var speed: float = 100.0
@export var max_health: int = 30
@export var damage: int = 20   # amíg érintkezik, ennyit sebez

var health: int
var target: Node
@onready var anim: AnimatedSprite2D = $summoned_enemy

func _ready():
	health = max_health
	add_to_group("enemies")
	target = get_tree().get_first_node_in_group("players")
	anim.play("walk")

func _physics_process(delta):
	if target:
		var dir = (target.global_position - global_position).normalized()
		velocity = dir * speed
		move_and_slide()

# ha eléri a Player hurtboxát, sebzi
func _on_Hitbox_body_entered(body: Node):
	if body.is_in_group("hurtbox"):
		var parent = body.get_parent()
		if parent.is_in_group("players"):
			if parent.has_method("take_damage"):
				parent.take_damage(damage)
				print("Minion sebzett:", damage)

func _on_Hurtbox_body_entered(body: Node):
	if body.is_in_group("hitbox"):
		var parent = body.get_parent()
		if parent.has_method("deal_damage"):
			parent.deal_damage(self)

func deal_damage(target: Node):
	if target.has_method("take_damage"):
		target.take_damage(damage)

func take_damage(amount: int):
	health -= amount
	print("Minion kapott:", amount, "| élet:", health)
	if health <= 0:
		die()

func die():
	queue_free()

extends CharacterBody2D 

@export var speed: float = 50.0 
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox: EnemyHitBox = $EnemyHitBox
@onready var hurtbox: EnemyHurtBox = $EnemyHurtBox
@onready var health: Health = $Health
@onready var health_label: Label = $HealthLabel

var target: Node = null 

func _ready():
	target = get_tree().get_first_node_in_group("players")
	health.health_depleted.connect(_on_health_depleted)
	health.health_changed.connect(_update_health_label)
	_update_health_label()

func _physics_process(delta):
	if target:
		var dir = (target.global_position - global_position).normalized()
		velocity = dir * speed
		move_and_slide
		velocity = dir.normalized() * speed if dir != Vector2.ZERO else Vector2.ZERO
		anim.play("walk")
		move_and_slide()
		if dir != Vector2.ZERO:
			anim.flip_h = dir.x < 0




func _on_health_depleted():
	ScoreManager.add_point(10)
	queue_free()
	print("Enemy dead")

func _update_health_label():
	health_label.text = "HP: %d" % health.health

extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var health = $Health
@export var speed: float = 65

var target: Node = null
var triggered = false

func _ready():
	target = get_tree().get_first_node_in_group("players")
	anim.play("defa")
	$EnemyHitBox.monitorable = false
	$EnemyHurtBox.monitorable = false
	health.health_depleted.connect(_on_health_depleted)
	velocity.y = 0


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is PlayerHitBox:
		anim.play("transform")
		triggered = true

func _physics_process(delta):
	if triggered == true and target:
			var dir = (target.global_position - global_position).normalized()
			velocity = dir * speed
			anim.play("walk")
			move_and_slide()


func live():
	if triggered == true:
		$EnemyHitBox.monitorable = true
		$EnemyHurtBox.monitorable = true

func _on_health_depleted():
	queue_free()

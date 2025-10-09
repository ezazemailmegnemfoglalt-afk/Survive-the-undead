extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var health = $Health
@onready var detection_area = $Area2D
@export var speed: float = 65

var target: Node = null
var triggered = false

func _ready():
	target = get_tree().get_first_node_in_group("players")
	anim.play("defa")
	$EnemyHitBox.monitorable = false
	$EnemyHurtBox.monitorable = false
	health.health_depleted.connect(_on_health_depleted)
	
	# Connect signals
	detection_area.area_entered.connect(_on_area_2d_area_entered)
	anim.animation_finished.connect(_on_animation_finished)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is PlayerHitBox and not triggered:
		triggered = true
		anim.play("transform")
		print("Enemy triggered - starting transform")

func _on_animation_finished():
	if anim.animation == "transform":
		$EnemyHitBox.monitorable = true
		$EnemyHurtBox.monitorable = true
		anim.play("walk")
		print("Transform finished - enemy active!")

func _physics_process(delta):
	if triggered and target:
		var dir = (target.global_position - global_position).normalized()
		velocity = dir * speed
		move_and_slide()

func _on_health_depleted():
	queue_free()

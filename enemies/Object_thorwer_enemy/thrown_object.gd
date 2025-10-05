extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $ThrownBone
@export var speed: float = 500.0

@onready var follow_timer = $FollowTimer
@export var folow_time: float =0.2

var target: Node = null

func _ready():
	anim.play("thrown")
	target = get_tree().get_first_node_in_group("players")
	follow_timer.wait_time = folow_time
	follow_timer.timeout.connect(_on_follow_timer_timeout)
	follow_timer.start()


func _physics_process(delta):
		if target:
			var dir = (target.global_position - global_position).normalized()
			velocity = dir * speed
			anim.play("walk")
			move_and_slide()
			
func _on_follow_timer_timeout():
	queue_free()

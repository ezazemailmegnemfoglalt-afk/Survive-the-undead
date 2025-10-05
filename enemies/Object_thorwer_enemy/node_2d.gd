extends CharacterBody2D
@onready var anim = $AnimatedSprite2D
@onready var summon_place1 = $SummonPlace1
@onready var summon_place2 = $SummonPlace2
@onready var summon_place3 = $SummonPlace3
@onready var summon_place4 = $SummonPlace4
@onready var follow_timer = $FollowTimer
@onready var summon_timer = $SummonTimer
@export var summonedshit : PackedScene
@export var summonedshitt : PackedScene
@export var summonedshittt : PackedScene
@export var summonedshitttt : PackedScene
@export var follow_time: float = 2.0
@export var wait_time: float = 1.0
@export var speed: float = 5

var target: Node = null

func _ready():
	target = get_tree().get_first_node_in_group("players")
	summon_timer.wait_time = wait_time
	summon_timer.timeout.connect(_on_summon_timer_timeout)
	summon_timer.start()
	anim.play("default")

func _on_summon_timer_timeout():
	print("enemy summoned")

	var enemy = summonedshit.instantiate()
	if summon_place1:
		enemy.global_position = summon_place1.global_position
		get_parent().add_child(enemy)
	var ennemy = summonedshitt.instantiate()
	if summon_place2:
		ennemy.global_position = summon_place2.global_position
		get_parent().add_child(ennemy)
	var ennnemy = summonedshittt.instantiate()
	if summon_place3:
		ennnemy.global_position = summon_place3.global_position 
		get_parent().add_child(ennnemy)
	var ennnnemy = summonedshitttt.instantiate()
	if summon_place4:
		ennnnemy.global_position = summon_place4.global_position 
		get_parent().add_child(ennnnemy)

func _physics_process(delta: float) -> void:
	if target:
		var dir = (target.global_position - global_position).normalized()
		velocity = dir * speed
		anim.play("walk")
		move_and_slide()

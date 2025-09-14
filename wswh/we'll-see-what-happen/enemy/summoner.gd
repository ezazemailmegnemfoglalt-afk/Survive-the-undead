extends CharacterBody2D

@export var summon_scene: PackedScene
@onready var health: Health = $Health
@onready var health_label: Label = $HealthLabel
@onready var summon_timer: Timer = Timer.new()
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var animtime: Timer = Timer.new()

func _ready():
	health.health_depleted.connect(_on_health_depleted)
	health.health_depleted.connect(_on_health_depleted)
	health.health_changed.connect(_update_health_label)
	_update_health_label()

	animtime.wait_time = 2.0
	summon_timer.wait_time = 3.0
	summon_timer.autostart = true
	summon_timer.one_shot = false
	summon_timer.timeout.connect(summon)
	add_child(summon_timer)

	anim.play("default")

func _on_summon_timer_timeout():
	anim.play("summoning")

	var t = Timer.new()
	t.wait_time = 1.0  # az "summon" animáció hossza másodpercben
	t.one_shot = true
	t.timeout.connect(func(): anim.play("default"))
	add_child(t)
	t.start()

	summon()

func _play_summon_animation():
	anim.play("summoning")  # feltételezve, hogy van ilyen nevű animáció
	await anim.animation_finished
	anim.play("default") 

func summon():
	anim.play("default")
	if summon_scene:
		for i in range(3):
			var s = summon_scene.instantiate()
			s.global_position = global_position + Vector2(50 * i, 0)
			get_tree().current_scene.add_child(s)
			anim.play("summoning")

func _on_health_depleted():
	queue_free()
	print("summoner meghalt")


func _update_health_label():
	health_label.text = "HP: %d" % health.health

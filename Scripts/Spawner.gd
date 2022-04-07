extends Node2D

onready var enemy = preload("res://Scenes/Enemy.tscn")
var on = true

var min_wait_time :float = 6

func _ready():
	if on:
		$Cooldown.wait_time = rand_range(min_wait_time,min_wait_time+1)
		$Cooldown.start()
		get_parent().get_node("Scramble").play("Spin")

func spawn():
	if on:
		var enemies = enemy.instance()
		enemies.global_position = global_position
		get_tree().get_root().get_node("Node2D/YSort").add_child(enemies)

func _on_Cooldown_timeout():
	if on:
		spawn()
		$Cooldown.wait_time = rand_range(min_wait_time,min_wait_time+1)
		if min_wait_time > 2:
			min_wait_time -= 0.15
		$Cooldown.start()

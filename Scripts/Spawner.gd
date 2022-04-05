extends Node2D

onready var enemy = preload("res://Scenes/Enemy.tscn")
var on = true

func _ready():
	if on:
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
		if $Cooldown.wait_time > 2:
			$Cooldown.wait_time -= 0.15
		$Cooldown.start()

extends KinematicBody2D

onready var player = get_tree().get_root().get_node("Node2D/YSort/Player")
onready var tower = get_tree().get_root().get_node("Node2D/YSort/Tower")

var target = Vector2()
var velocity = Vector2()

var can_move :bool = true
var speed :int = 150


func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	target = tower.global_position
	if can_move == true:
		velocity = move_and_slide(velocity)

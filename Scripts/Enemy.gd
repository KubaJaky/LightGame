extends KinematicBody2D

onready var player = get_tree().get_root().get_node("Node2D/YSort/Player")

var target = Vector2()
var velocity = Vector2()

var speed :int = 100

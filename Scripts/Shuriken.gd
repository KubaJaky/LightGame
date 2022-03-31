extends KinematicBody2D

onready var destroyanim = $Destroy

var damage : int = 0
var speed :float = 500
var velocity :Vector2 = Vector2()

func _physics_process(delta):
	velocity = Vector2(speed, 0).rotated(rotation)
	$WeaponIcon.rotation_degrees += speed/40
	
	velocity = move_and_slide(velocity)
	


func _on_LifeTime_timeout():
	destroyanim.play("Destroy")

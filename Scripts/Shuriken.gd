extends KinematicBody2D

onready var destroyanim = $Destroy

var max_bodies :int = 3
var bodies_pierced :int = 0

var damage : int = 0
var speed :float = 500
var velocity :Vector2 = Vector2()

func _physics_process(delta):
	velocity = Vector2(speed, 0).rotated(rotation)
	$WeaponIcon.rotation_degrees += speed/40
	
	if bodies_pierced >= max_bodies:
		queue_free()
	
	velocity = move_and_slide(velocity)
	


func _on_LifeTime_timeout():
	destroyanim.play("Destroy")


func _on_Hit_body_entered(body):
	if (body.is_in_group("Enemy")):
		bodies_pierced += 1
		body.damaged()
		body.hp -= damage

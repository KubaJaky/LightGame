extends StaticBody2D

onready var towerAnim = get_node("TowerAnim")

var power :int = 2000
var attacked :bool = false

func _physics_process(delta):
	if attacked:
		power -= 0.01
		print(power)

func _on_VisibilityArea_body_entered(body):
	if (body.is_in_group("Player")):
		towerAnim.play("Visibility")
		
		
func _on_VisibilityArea_body_exited(body):
	if (body.is_in_group("Player")):
		towerAnim.play_backwards("Visibility")


func _on_DamageArea_body_entered(body):
	if (body.is_in_group("Enemy")):
		body.attacking = true
		body.can_move = false
		attacked = true
		body.stop()

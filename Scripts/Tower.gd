extends StaticBody2D

onready var towerAnim = get_node("TowerAnim")
onready var deathscreenanim = get_tree().get_root().get_node("Node2D/DeathScreen/DeathScreenAnim")

var power :int = 20
var attacked :bool = false
var destroyed :bool = false

func _physics_process(delta):
	if attacked and power > 0:
		power -= 0.01
		print(power)
	if power <= 0 and !destroyed:
		destroyed = true
		towerAnim.play("Destroyed")

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
		
func deathscreen():
	deathscreenanim.play("DeathScreenClose")

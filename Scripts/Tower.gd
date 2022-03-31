extends StaticBody2D

onready var towerAnim = get_node("TowerAnim")

func _ready():
	pass

func _on_VisibilityArea_body_entered(body):
	if (body.is_in_group("Player")):
		towerAnim.play("Visibility")
		
		
func _on_VisibilityArea_body_exited(body):
	if (body.is_in_group("Player")):
		towerAnim.play_backwards("Visibility")

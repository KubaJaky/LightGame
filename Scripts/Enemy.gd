extends KinematicBody2D

onready var player = get_tree().get_root().get_node("Node2D/YSort/Player")
onready var tower = get_tree().get_root().get_node("Node2D/YSort/Tower")
onready var icon = $Icon
onready var anim = $Anim

var dead :bool = false

var attacking :bool = false

var target = Vector2()
var velocity = Vector2()

var can_move :bool = true
var speed :int = 150

var hp :int = 20

func _ready():
	anim.play("Walk")

func _physics_process(delta):
	# Movement / finding the tower
	velocity = position.direction_to(target) * speed
	target = tower.global_position
	if can_move == true:
		velocity = move_and_slide(velocity)
		
	if tower.global_position.x < global_position.x and !icon.scale.x == -0.4:
		icon.scale.x = -0.4
	elif tower.global_position.x >= global_position.x and !icon.scale.x == 0.4:
		icon.scale.x = 0.4
		
	if attacking and hp > 0:
		tower.attacked = true
		
	# Death
	if hp <= 0:
		if attacking:
			attacking = false
			tower.attacked = false
		can_move = false
		dead = true
		die()
		
		
func die():
	if dead:
		queue_free()
		
func stop():
	if attacking:
		anim.play("RESET")

func _on_Damagedetect_body_entered(body):
	if (body.is_in_group("Player")):
		if body.character.dashing == true:
			hp -= 20

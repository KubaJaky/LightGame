extends KinematicBody2D

onready var character = get_child(0)
onready var weapon = get_child(0).get_node("Weapon")
onready var weaponIcon = get_child(0).get_node("Weapon/WeaponIcon")
var throwable


var velocity = Vector2()
var base_speed :int = 300
var speed :int = base_speed

var damage :int = 10

var facing_right :bool = true
var facing_left :bool = false

export var on :bool = true


func get_input():
	velocity = Vector2()
	
	# Walking animation
	if (Input.is_action_pressed("Up") or Input.is_action_pressed("Down") or Input.is_action_pressed("Right") or (Input.is_action_pressed("Left"))):
		character.get_node("Walking").play("Walking")
	else:
		character.get_node("Walking").play("RESET")
		
	# Facing left or right
	if (Input.is_action_pressed("Left")):
		facing_right = false
		facing_left = true
		character.get_node("CharacterIcon").scale.x = -0.4
	else:
		facing_left = false
		facing_right = true
		character.get_node("CharacterIcon").scale.x = 0.4
	
	# Attack
	if (Input.is_action_just_pressed("Attack")):
		if (character.can_attack):
			character.Attack()
			var throw = throwable.instance()
			throw.damage = damage
			get_parent().add_child(throw)
			throw.rotation_degrees = weapon.rotation_degrees
			throw.global_position = weaponIcon.global_position
	
	# Movement
	if (Input.is_action_pressed("Up")):
		velocity.y -= 1
	if (Input.is_action_pressed("Down")):
		velocity.y += 1
	if (Input.is_action_pressed("Right")):
		velocity.x += 1
	if (Input.is_action_pressed("Left")):
		velocity.x -= 1
	
	weapon.look_at(get_global_mouse_position())
	velocity = velocity.normalized() * speed
	
	# Skill
	if (Input.is_action_just_pressed("Skill")):
		character.Skill()
		
	move_and_slide(velocity)
	

func reset_move():
	character.get_node("Walking").play("RESET")

func _physics_process(delta):
	if on:
		get_input()
	

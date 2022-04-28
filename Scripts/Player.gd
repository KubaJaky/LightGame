extends KinematicBody2D

onready var character = get_child(0)
onready var weapon = get_child(0).get_node("Weapon")
onready var weaponIcon = get_child(0).get_node("Weapon/WeaponIcon")
onready var appear_particle = get_child(0).get_node("Appear")
onready var save = get_tree().get_root().get_node("Node2D/Save")
onready var tower = get_tree().get_root().get_node("Node2D/YSort/Tower")
var throwable

var velocity = Vector2()

var base_speed :int = 250
var speed :int = base_speed
var damage :int = 7

var facing_right :bool = true
var facing_left :bool = false

export var on :bool = true

var time :float = 0
var kills :int = 0
var score = 0

var coins :int = 0
var money_mult :float = 1.0

func _ready():
	var soundID = int(rand_range(1,3))
	get_tree().get_root().get_node("Node2D/BGMusic"+str(soundID)).play()
	appear_particle.restart()
	appear_particle.emitting = true
	
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
			ShootSound()
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
		if (!tower.destroyed and tower.power > 0):
			character.Skill()
		
	move_and_slide(velocity)
	
func add_coins():
	coins += (int(score)/10) * money_mult
	save.Coins()
	
func ShootSound():
	var soundID = int(rand_range(1,5))
	get_child(0).get_node("Attack"+str(soundID)).play()

func reset_move():
	character.get_node("Walking").play("RESET")

func _physics_process(delta):
	if on:
		time += delta
		get_input()
		score = int(time) * (1 + (kills/10))
	

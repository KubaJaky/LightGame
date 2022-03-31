extends Node2D

onready var player = get_parent()
onready var dash_timer = $DashTimer
onready var skill_cd = $SkillCD
onready var dash_particle = $dash_particle
onready var attack_cd = $AttackCD
onready var attack_anim = $Attacking

var targetPosition :Vector2

var can_attack :bool = true

var can_dash :bool = true
var dashing :bool = false
var dash_speed :int = 500

func _ready():
	player.throwable = load('res://Scenes/Shuriken.tscn')

func _physics_process(delta):
	look_at(global_position)
	
	if dashing:
		player.global_position = lerp(player.global_position,targetPosition,0.5)

func Attack():
	can_attack = false
	attack_cd.start()
	attack_anim.play("Attacking")

func Skill():
	if !dashing and can_dash:
		if player.facing_left:
			dash_particle.texture = load('res://Sprites/Characters/Character0/' + name + "mirror" + ".png")
		elif player.facing_right:
			dash_particle.texture = load('res://Sprites/Characters/Character0/' + name + ".png")
		dash_particle.restart()
		dash_particle.emitting = true
		dashing = true
		dash_timer.start()
		targetPosition = player.global_position + (player.velocity/player.base_speed) * dash_speed

func _on_DashTimer_timeout():
	skill_cd.start()
	can_dash = false
	dashing = false
	dash_particle.emitting = false

func _on_SkillCD_timeout():
	can_dash = true

func _on_AttackCD_timeout():
	can_attack = true

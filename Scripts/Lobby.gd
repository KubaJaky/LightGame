extends CanvasLayer

onready var player = get_tree().get_root().get_node("Node2D/YSort/Player")
onready var character = player.get_child(0)
onready var save = get_tree().get_root().get_node("Node2D/Save")
onready var screenanim = $DeathScreenAnim
onready var click = $Click
onready var click2 = $Click2
onready var SkillCD = get_parent().get_node("UI/SkillCD")
onready var SkillCD_text = get_parent().get_node("UI/SkillCD/CD_text")
onready var tower = get_tree().get_root().get_node("Node2D/YSort/Tower")
onready var TowerBar = get_parent().get_node("UI/TowerHp")
var tower_max_hp :int

onready var score = get_node("Lobby/Panel/Score")
onready var time = get_node("Lobby/Panel/Time")
onready var kills = get_node("Lobby/Panel/Kills")
onready var bestScore = get_node("Lobby/Panel/BestScore")
onready var coins1 = get_node("Lobby/Panel/Coins")
onready var coins2 = get_node("Lobby/Armory/Coins2")

onready var atk_spd_cost_text = get_node("Lobby/Armory/BuyMenu/BuyAtkSpd/Cost")
onready var dmg_cost_text = get_node("Lobby/Armory/BuyMenu/BuyDmg/Cost")
onready var skill_cd_cost_text = get_node("Lobby/Armory/BuyMenu/BuySkillCd/Cost")
onready var mvn_spd_cost_text = get_node("Lobby/Armory/BuyMenu/BuyMvnSpd/Cost")
onready var mny_mult_cost_text = get_node("Lobby/Armory/BuyMenu/BuyMnyMult/Cost")
onready var twr_hp_cost_text = get_node("Lobby/Armory/BuyMenu/BuyTwrHp/Cost")


var atk_spd_cost :int = 10
var dmg_cost :int = 75
var skill_cd_cost :int = 25
var mvn_spd_cost :int = 75
var mny_mult_cost :int = 75
var twr_hp_cost :int = 75

func _ready():
	bestScore.text = "Best Score: " + str(save.save.BestScore)

func _physics_process(delta):
	# Score, Kills, Coins etc.
	score.text = "Score:" + str(player.score)
	Current_Time()
	kills.text = "Kills: " + str(player.kills)
	coins1.text = str(player.coins) + "¢"
	coins2.text = coins1.text
	
	# Skill Cooldown
	SkillCD.value = character.skill_cd.time_left*100
	if SkillCD.value > 0 and SkillCD_text.visible == false:
		SkillCD_text.visible = true
	elif SkillCD.value <= 0 and SkillCD_text.visible == true:
		SkillCD_text.visible = false
	if SkillCD_text.visible == true:
		SkillCD_text.text = str(round(character.skill_cd.time_left))
		
	# Tower HP
	TowerBar.value = tower.power
	
	# Costs of upgrades
	atk_spd_cost_text.text = str(atk_spd_cost) + "¢"
	dmg_cost_text.text = str(dmg_cost) + "¢"
	skill_cd_cost_text.text = str(skill_cd_cost) + "¢"
	mvn_spd_cost_text.text = str(mvn_spd_cost) + "¢"
	mny_mult_cost_text.text = str(mny_mult_cost) + "¢"
	twr_hp_cost_text.text = str(twr_hp_cost) + "¢"
	
func Current_Time():
	var minutes = int(player.time)/60
	var seconds = int(player.time) - (minutes*60)
	if(seconds < 10):
		time.text = "Time: " + str(minutes) + ":"  + "0" + str(seconds)
	else:
		time.text = "Time: " + str(minutes) + ":" + str(seconds)

func _on_UpgradeButton_pressed():
	screenanim.play("ChangeShopArmory")
	click2.play()

func _on_Back_pressed():
	screenanim.play_backwards("ChangeShopArmory")
	click2.play()


func _on_BuyAtkSpd_pressed():
	if player.coins >= atk_spd_cost:
		if save.save.atk_spd > 0.02:
			save.save.atk_spd -= 0.05
			save.save.atk_spd_anim += 0.05
			player.coins -= atk_spd_cost
			atk_spd_cost = atk_spd_cost * 1.5
			atk_spd_check()
			save.Coins()
			save.Costs()
			click.play()
		
func atk_spd_check():
	if save.save.atk_spd <= 0.02:
			$Lobby/Armory/BuyMenu/BuyAtkSpd.disabled = true
			atk_spd_cost_text.visible = false


func _on_BuyDmg_pressed():
	if player.coins >= dmg_cost:
		if save.save.damage < 20:
			save.save.damage += 5
			if save.save.damage > 20:
				save.save.damage = 20
			player.coins -= dmg_cost
			dmg_cost = dmg_cost * 1.5
			dmg_check()
			save.Coins()
			save.Costs()
			click.play()

func dmg_check():
	if save.save.damage >= 20:
			$Lobby/Armory/BuyMenu/BuyDmg.disabled = true
			dmg_cost_text.visible = false

func _on_BuySkillCd_pressed():
	if player.coins >= skill_cd_cost:
		if save.save.skill_cd > 0.5:
			save.save.skill_cd -= 0.1
			player.coins -= skill_cd_cost
			skill_cd_cost = skill_cd_cost * 1.5
			Skill_cd_check()
			save.Coins()
			save.Costs()
			click.play()

func Skill_cd_check():
	if save.save.skill_cd <= 0.5:
			$Lobby/Armory/BuyMenu/BuySkillCd.disabled = true
			skill_cd_cost_text.visible = false

func _on_BuyMvnSpd_pressed():
	if player.coins >= mvn_spd_cost:
		if save.save.mvn_spd < 750:
			save.save.mvn_spd += 250
			player.coins -= mvn_spd_cost
			mvn_spd_cost = mvn_spd_cost * 1.5
			Mvn_spd_check()
			save.Coins()
			save.Costs()
			click.play()

func Mvn_spd_check():
	if save.save.mvn_spd >= 750:
			$Lobby/Armory/BuyMenu/BuyMvnSpd.disabled = true
			mvn_spd_cost_text.visible = false

func _on_BuyMnyMult_pressed():
	if player.coins >= mny_mult_cost:
		if save.save.money_mult < 3.0:
			save.save.mone_mult += 0.5
			player.coins -= mny_mult_cost
			mny_mult_cost = mny_mult_cost * 1.5
			Mny_mult_check()
			save.Coins()
			save.Costs()
			click.play()

func Mny_mult_check():
	if save.save.money_mult >= 3.0:
			$Lobby/Armory/BuyMenu/BuyMnyMult.disabled = true
			mny_mult_cost_text.visible = false

func _on_BuyTwrHp_pressed():
	if player.coins >= twr_hp_cost:
		if save.save.tower_hp < 10000:
			save.save.tower_hp += 500
			player.coins -= twr_hp_cost
			twr_hp_cost = twr_hp_cost * 1.5
			Twr_hp_check()
			save.Coins()
			save.Costs()
			click.play()

func Twr_hp_check():
	if save.save.tower_hp >= 10000:
			$Lobby/Armory/BuyMenu/BuyTwrHp.disabled = true
			twr_hp_cost_text.visible = false

func _on_Retry_pressed():
	click.play()
	get_tree().change_scene("res://Scenes/World.tscn")


func _on_Menu_pressed():
	click.play()
	get_tree().change_scene("res://Scenes/Menu.tscn")

extends CanvasLayer

onready var player = get_tree().get_root().get_node("Node2D/YSort/Player")
onready var save = get_tree().get_root().get_node("Node2D/Save")
onready var screenanim = $DeathScreenAnim

onready var score = get_node("Lobby/Panel/Score")
onready var time = get_node("Lobby/Panel/Time")
onready var kills = get_node("Lobby/Panel/Kills")
onready var bestScore = get_node("Lobby/Panel/BestScore")
onready var coins1 = get_node("Lobby/Panel/Coins")
onready var coins2 = get_node("Lobby/Armory/Coins2")

func _ready():
	bestScore.text = "Best Score: " + str(save.save.BestScore)

func _physics_process(delta):
	score.text = "Score:" + str(player.score)
	Current_Time()
	kills.text = "Kills: " + str(player.kills)
	coins1.text = str(player.coins) + "¢"
	coins2.text = coins1.text
	
func Current_Time():
	var minutes = int(player.time)/60
	var seconds = int(player.time) - (minutes*60)
	if(seconds < 10):
		time.text = "Time: " + str(minutes) + ":"  + "0" + str(seconds)
	else:
		time.text = "Time: " + str(minutes) + ":" + str(seconds)

func _on_UpgradeButton_pressed():
	screenanim.play("ChangeShopArmory")

func _on_Back_pressed():
	screenanim.play_backwards("ChangeShopArmory")


func _on_BuyAtkSpd_pressed():
	if save.atk_spd > 0.02:
		save.atk_spd -= 0.05
		save.Coins()


func _on_BuyDmg_pressed():
	if save.damage < 20:
		save.damage += 5
		if save.damage > 20:
			save.damage = 20
		save.Coins()


func _on_BuySkillCd_pressed():
	if save.skill_cd > 0.5:
		save.skill_cd -= 0.25
		save.Coins()


func _on_BuyMvnSpd_pressed():
	if save.mvn_spd < 750:
		save.mvn_spd += 250
		save.Coins()

func _on_BuyMnyMult_pressed():
	pass 


func _on_BuyTwrHp_pressed():
	if save.tower_hp < 10000:
		save.tower_hp += 500
		save.Coins()

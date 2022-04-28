extends Node2D

var save = {
	"BestScore":0,
	"coins":0,
	"CharacterId":0,
	"atk_spd":1.0,
	"atk_spd_anim":0.5,
	"damage": 7,
	"skill_cd":1.0,
	"mvn_spd":250,
	"money_mult":1.0,
	"tower_hp":2000,
	"atk_spd_cost":10,
	"dmg_cost":75,
	"skill_cd_cost":25,
	"mvn_spd_cost":25,
	"mny_mult_cost":75,
	"twr_hp_cost":75,
}

onready var player = get_tree().get_root().get_node("Node2D/YSort/Player")
onready var character = get_tree().get_root().get_node("Node2D/YSort/Player/Character" + str(save.CharacterId))
onready var score = get_tree().get_root().get_node("Node2D/DeathScreen/Lobby/Panel/BestScore")
onready var tower = get_tree().get_root().get_node("Node2D/YSort/Tower")
onready var lobby = get_tree().get_root().get_node("Node2D/DeathScreen")

# do not try to save in _ready, it doesn't work
func _ready():
	if load_data():
		score.set_text(str("Best Score: ",round(save.BestScore)))
		player.coins = save.coins
		player.base_speed = save.mvn_spd
		player.speed = save.mvn_spd
		player.damage = save.damage
		player.money_mult = save.money_mult
		
		tower.power = save.tower_hp
		lobby.TowerBar.max_value = save.tower_hp
		
		character.skill_mult = save.skill_cd
		character.attack_spd_mult = save.atk_spd
		character.skill_cd.wait_time = character.skill_cd.wait_time * character.skill_mult
		character.atk_spd.wait_time = character.atk_spd.wait_time * character.attack_spd_mult
#		character.attack_anim.playback_speed = save.atk_spd_anim
		
		lobby.atk_spd_cost = save.atk_spd_cost
		lobby.dmg_cost = save.dmg_cost
		lobby.skill_cd_cost = save.skill_cd_cost
		lobby.mvn_spd_cost  = save.mvn_spd_cost
		lobby.mny_mult_cost = save.mny_mult_cost
		lobby.twr_hp_cost = save.twr_hp_cost
		
		lobby.atk_spd_check()
		lobby.dmg_check()
		lobby.Skill_cd_check()
		lobby.Mvn_spd_check()
		lobby.Mny_mult_check()
		lobby.Twr_hp_check()
		
		lobby.SkillCD.max_value = lobby.character.skill_cd.wait_time*100
		
		print(save)


# saves everyhing in the "save" variable
func save_data():
	var file = File.new()
	file.open("user://save",file.WRITE_READ)
	file.store_var(save)
	file.close()
	
# and load
func load_data():
	var file = File.new()
	if not file.file_exists("user://save"):
		return false
	file.open("user://save",file.READ)
	save = file.get_var()
	file.close()
	return true
	
func BestScore():
	if player.score > save.BestScore:
		save.BestScore = player.score
		score.set_text("Best Score: " + str(int(save.BestScore)))
		save_data()

func Coins():
	save.coins = player.coins
	save_data()
	
func Costs():
	save.atk_spd_cost = lobby.atk_spd_cost
	save.dmg_cost = lobby.dmg_cost
	save.skill_cd_cost = lobby.skill_cd_cost
	save.mvn_spd_cost = lobby.mvn_spd_cost 
	save.mny_mult_cost = lobby.mny_mult_cost 
	save.twr_hp_cost = lobby.twr_hp_cost
	save_data()

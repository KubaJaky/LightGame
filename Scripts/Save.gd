extends Node2D

var save = {
	"BestScore":0,
	"coins":0,
	"CharacterId":0,
	"atk_spd":0.6,
	"damage": 7,
	"skill_cd":1.0,
	"mvn_spd":300,
	"money_mult":1.0,
	"tower_hp":2000,
}

onready var player = get_tree().get_root().get_node("Node2D/YSort/Player")
onready var character = get_tree().get_root().get_node("Node2D/YSort/Player/Character" + str(save.CharacterId))
onready var score = get_tree().get_root().get_node("Node2D/DeathScreen/Lobby/Panel/BestScore")

# do not try to save in _ready, it doesn't work
func _ready():
	if load_data():
		score.set_text(str("Best Score: ",round(save.BestScore)))


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

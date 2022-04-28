extends Node2D


func _ready():
	randomize()
	$Character0/Walking.play("Walking")
	$Ambient.play("Ambient")


func _on_Play_pressed():
	$Click.play()
	get_tree().change_scene("res://Scenes/World.tscn")

func _on_Quit_pressed():
	$Click.play()
	get_tree().quit()


func _on_SFX_value_changed(value):
	$Click2.play()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)


func _on_Music_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)

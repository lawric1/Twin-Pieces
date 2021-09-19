extends Control

export(PackedScene) var game_scene

func _ready():
	Global.score = 0

func _on_play_pressed():
	$AudioStreamPlayer.play()
	get_tree().change_scene_to(game_scene)
	
	
func _on_quit_pressed():
	$AudioStreamPlayer.play()
	get_tree().quit()

func _on_mute_pressed():
	if Music.playing == false:
		Music.play()
	Music.stop()

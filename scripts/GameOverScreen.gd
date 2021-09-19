extends Control

func _ready():
	$FinalScore.text = "Final Score: " + str(Global.score)

func _on_Restart_pressed():
	$AudioStreamPlayer.play()
	get_tree().change_scene('res://scenes/MenuScreen.tscn')


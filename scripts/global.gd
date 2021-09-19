extends Node

var gameover = load('res://scenes/GameOverScreen.tscn')

var score = 0

func _ready():
	pass
	
func game_over():

	var _scene = get_tree().change_scene_to(gameover)

extends Control


onready var timer = get_node("Timer")
onready var pb = get_node("TextureProgress")

func _ready():
	timer.wait_time = pb.value
	timer.start()

func _process(_delta):
#	print(timer.time_left)
	pb.value = timer.time_left


func _on_Timer_timeout():
	Global.game_over()

extends Node2D

onready var shadowscene = preload("res://scenes/shadow.tscn")

var rng : RandomNumberGenerator = RandomNumberGenerator.new()
var spots_taken = Array()

var box_position
var mirror_position

var box_positions = Array()
var shadow_positions = Array()

func _ready():
	spawn_shadows()
#	
	var timer = Timer.new()
	timer.set_wait_time(1.0)
	timer.set_one_shot(false)
	timer.connect("timeout", self, "check_positions")
	add_child(timer)
	timer.start()
#	print(get_tree().get_nodes_in_group('boxes'))



func check_positions():
	for box in get_tree().get_nodes_in_group("boxes"):
		mirror_position = Vector2((box.position.x + 176), box.position.y)
		box_positions.append(mirror_position)
		
	for shadow in get_tree().get_nodes_in_group("shadows"):
		shadow_positions.append(shadow.position)
#
	for item in box_positions:
		if not item in shadow_positions:
			box_positions = Array()
			shadow_positions = Array()
			return false
	
	for shadow in get_tree().get_nodes_in_group("shadows"):
		shadow.queue_free()
		spots_taken = Array()
	
	add_score()
	
	spawn_shadows()
	$Timer.timer.start()
	
	box_positions = Array()
	shadow_positions = Array()

func spawn_shadows():
	rng.randomize()
	var s = 0
	while s < 6:
		var shadow = shadowscene.instance()
		randomize()
		var x = rng.randi_range(192, 288)
		randomize()
		var y = rng.randi_range(16, 144)
		
		if (x % 16) + (y % 16) == 0 and not spots_taken.has(Vector2(x, y)):
			shadow.position = Vector2(x, y)
			spots_taken.append(shadow.position)
			add_child(shadow)
			move_child(shadow, 1)
			s += 1

func add_score():
	Global.score += 100
	$ScoreLabel.text = str(Global.score)
	
	
	

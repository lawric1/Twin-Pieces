extends Area2D


onready var mat

export var speed = 5

var tile_size = 16
var selected = false

#these vars are for basic Drag&Drop
var Mouse_In = false
var Mpos
var Objectdrag = false
var box_ahead = false
#these vars are used for locking sprite to gird movement
var Mpos_X
var Mpos_Y

func _ready():
	add_to_group("boxes")
	
	mat = $Sprite.get_material().duplicate(true)
	$Sprite.set_material(mat)
	
	set_physics_process(true)
 
func _physics_process(_delta):
#these are to refresh Mouse Postion check
	Mpos = get_global_mouse_position()
#the floor code here is to give X and Y to simpify the movement by Tilesize incriments and keeping the curor in the center. 
	Mpos_X = floor(Mpos.x/tile_size)*tile_size
	Mpos_Y = floor(Mpos.y/tile_size)*tile_size
	
#Updates the Mpos on Current pos
	if Mouse_In == true:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			
			Mpos_X = clamp(Mpos_X, 16, 112)
			Mpos_Y = clamp(Mpos_Y, 16, 144)
			
#I put Mpos_X & Mpos_Y through a flooring as stated above, you can remove them and use Mpos to get a smooth drag and drop
			if not check_box_positions(Mpos_X, Mpos_Y) and selected:
				set_global_position(Vector2 (Mpos_X,Mpos_Y))
				$AudioStreamPlayer.play()
				
			Objectdrag = true 
			
		else:
			Objectdrag = false
			
func check_box_positions(x, y):
	for box in get_tree().get_nodes_in_group('boxes'):
		if box.position.x == x and box.position.y == y:
			return true
	
	return false
		
func _on_player_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		
		for box in get_tree().get_nodes_in_group('boxes'):
			box.mat.set_shader_param("outLineSize", 0)
			box.selected = false
			
		selected = true
		mat.set_shader_param("outLineSize", 0.012)
		
func _on_box_mouse_entered():
	Mouse_In = true
	
	if not selected:
		mat.set_shader_param("outLineSize", 0.012)

func _on_box_mouse_exited():
	if Objectdrag == false:
		Mouse_In = false
	
	if not selected:
		mat.set_shader_param("outLineSize", 0)


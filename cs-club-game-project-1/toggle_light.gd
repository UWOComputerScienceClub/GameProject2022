extends Light2D
var elapsed = 0.0
var starting_mouse_pos
onready var player = get_parent().get_node(".")
onready var enemy1 = get_parent().get_node("Enemy1")
# Called when the node enters the scene tree for the first time.
func _ready():
	energy = 1.0
	scale = Vector2(0.10, 0.15)
	starting_mouse_pos = get_global_mouse_position()

func _input(event):
	if Input.is_action_just_pressed("toggle_flashlight"):
		if energy == 1.0:
			energy = 2.0
			scale = Vector2(0.25, 0.25)
			PlayerLightEnabled.isLightEnabled = true
		else:
			energy = 1.0
			scale = Vector2(0.10, 0.15)
			PlayerLightEnabled.isLightEnabled = false

#func _process(delta):
#	global_rotation = lerp_angle(global_rotation, get_global_mouse_position().angle(), delta * 2)

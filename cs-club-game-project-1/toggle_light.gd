extends Light2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	energy = 1.0
	scale = Vector2(0.10, 0.15)

func _input (event):
	if Input.is_action_just_pressed("toggle_flashlight"):
		if energy == 1.0:
			energy = 2.0
			scale = Vector2(0.25, 0.25)
			PlayerLightEnabled.isLightEnabled = true
		else:
			energy = 1.0
			scale = Vector2(0.10, 0.15)
			PlayerLightEnabled.isLightEnabled = false

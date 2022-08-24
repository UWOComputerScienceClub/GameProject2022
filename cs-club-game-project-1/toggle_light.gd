extends Light2D
var elapsed = 0.0
var starting_mouse_pos
onready var player = get_parent().get_node(".")

# Called when the node enters the scene tree for the first time.
func _ready():
	energy = 1.0 # Intensity of light
	scale = Vector2(0.10, 0.15) # Scale of the light texture

# Called when there is an input event (movement, toggling light, etc).
func _input(event):
	if (Input.is_action_just_pressed("toggle_flashlight") and
		PlayerLightEnabled.hasFlashlight): # If the player presses 'F'...
		if energy == 1.0: 							  # If the flashlight is not on...
			energy = 2.0
			scale = Vector2(0.25, 0.25)
			PlayerLightEnabled.isLightEnabled = true  # ...Turn the flashlight on.
		else:										  # Else,...
			energy = 1.0
			scale = Vector2(0.10, 0.15)
			PlayerLightEnabled.isLightEnabled = false # ...Turn the flashlight off.

extends Node2D

var bar_red = preload("res://art/barHorizontal_red.png")
var bar_green = preload("res://art/barHorizontal_green.png")
var bar_yellow = preload("res://art/barHorizontal_yellow.png")

onready var healthbar = $HealthBar

# Called when the node enters the scene tree for the first time.
func _ready():
	hide() # Healthbar is hidden by default.
	if get_parent() and get_parent().get("max_health"): # If the parent node exists and has a max_health value...
		healthbar.max_value = get_parent().max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_rotation = 0 # Do not move position of the healthbar relative to parent, even if the parent does rotate.
	if (get_parent().is_in_light and
		PlayerLightEnabled.isLightEnabled): # If parent node is in player's light and the flashlight is on...
		$VisibilityTimer.start()			# Start the visibility timer (Determines how long healthbar is visible after parent is damaged).

#User-made function. When called, updates healthbar to appropriate colour based on value provided.
func update_healthbar(value):	
	healthbar.texture_progress = bar_green
	if value < healthbar.max_value * 0.7:
		healthbar.texture_progress = bar_yellow
	if value < healthbar.max_value * 0.35:
		healthbar.texture_progress = bar_red
	if (value < healthbar.max_value and 
		not $VisibilityTimer.is_stopped()): # If the parent node has been damaged and the visibility timer hasn't stopped yet.
		# Print statement to be used for testing purposes ONLY. Delete before final release.
		#print($VisibilityTimer.time_left)
		show() # Display the healthbar.
	else:
		hide() # Else, hide the healthbar.
	healthbar.value = value # Set the value of the healthbar to the value provided.

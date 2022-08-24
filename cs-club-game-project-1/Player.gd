extends KinematicBody2D

export var speed = 75 # How fast the player will move (pixels/sec).
var velocity = Vector2() # The player's movement vector.
var wall = load("res://Wall.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Print statements to be used for testing purposes ONLY. Delete before final release.
	#print(PlayerLightEnabled.isLightEnabled)
	#print(get_node("Light2D/Area2D").overlaps_body(enemy))
		
	velocity = Vector2.ZERO # Set player's movement vector to zero by default
	
	if Input.is_action_pressed("move_right"): # If player hits 'D' or Right Arrow on keyboard...
		velocity.x += 1						  # ...Move player character right.
	if Input.is_action_pressed("move_left"):  # If player hits 'A' or Left Arrow on keyboard...
		velocity.x -= 1						  # ...Move player character left.
	if Input.is_action_pressed("move_down"):  # If player hits 'S' or Down Arrow on keyboard...
		velocity.y += 1						  # ...Move player character down. (Y-axis is inverted, so '+' means down.)
	if Input.is_action_pressed("move_up"):	  # If player hits 'W' or Up Arrow on keyboard...
		velocity.y -= 1						  # ...Move player character up. (Y-axis is inverted, so '-' means up.)
		
	if Input.is_action_pressed("sprint_toggle"): # While player is holding down Shift...
		speed = 150								 # Player is sprinting.
	else: 										 # Else...
		speed = 75								 # Player is walking.
		
	if velocity.length() > 0: 					 # If the player is moving...
		velocity = velocity.normalized() * speed # Set their movement speed accordingly.

	position += velocity * delta # Update player position based on moevement speed and the time since the last frame.

# Called every frame. 'delta' is the elapsed time since the previous frame. Physics is synced up with framerate.
func _physics_process(delta):
	look_at(get_global_mouse_position()) # Makes player character look at mouse cursor at all times.
	
	var collision = move_and_collide(velocity * delta) # Gather info about whether or not player is colliding with anything.
	if (collision):
		if (not collision.collider.has_method("isWall")): # If the player is colliding with something without isWall() method (Like, say, an enemy...)
			if (not collision.collider.has_method("isFlashlight")):
				if (PlayerLightEnabled.hasFlashlight):
					position.x = 32
					position.y = 32
					#position.x = 872							  	  # Reset player x and y to starting position.
					#position.y = 496
			else:
				PlayerLightEnabled.hasFlashlight = true
				if $Light2D.energy == 1.0: 							  # If the flashlight is not on...
					$Light2D.energy = 2.0
					$Light2D.scale = Vector2(0.25, 0.25)
					PlayerLightEnabled.isLightEnabled = true

extends Node2D

var Enemy1 = load("res://Enemy1.tscn") # Creates Enemy1 resource as a shortcut to Enemy1 scene.
var Enemy2 = load("res://Enemy2.tscn") # Creates Enemy2 resource as a shortcut to Enemy2 scene.

var enemy1_array = [] # Stores all enemies in the level (Enemy1)
var enemy2_array = [] # Stores all enemies in the level (Enemy2)

var rng = RandomNumberGenerator.new() # Random number generator

var total_num_enemies1 = 2 # Number of enemies in the scene
var total_num_enemies2 = 2 # Number of enemies in the scene

var space_state # See comments on lines 14-15 for info
onready var player = get_node("Player") # Fetches the player node from the given NodePath.
onready var player_light_area = get_node("Player/Light2D/Area2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	#pass
	
	space_state = get_world_2d().direct_space_state # Direct access to the level's physics state. 
													# Used for detecting collisions.
	for n in total_num_enemies1:
		enemy1_array.insert(n, Enemy1.instance()) # Inserts an instance of Enemy1 into the array at index value n.
		
		add_child(enemy1_array[n]) # Adds this instance of Enemy1 to the Main scene as a child node.
		
		rng.randomize()
		
		enemy1_array[n].position.x = rng.randi_range(0, 1900) # Sets the initial x-coordinate of this instance of 
															  # Enemy 1 via a bounded int number generator.
		rng.randomize()										
															
		enemy1_array[n].position.y = rng.randi_range(0, 1000) # Sets the initial y-coordinate of this instance of 
															  # Enemy 1 via a bounded int number generator.

	for n in total_num_enemies2:
		enemy2_array.insert(n, Enemy2.instance()) # Inserts an instance of Enemy2 into the array at index value n.
		
		add_child(enemy2_array[n]) # Adds this instance of Enemy2 to the Main scene as a child node.
		
		rng.randomize()
		
		enemy2_array[n].position.x = rng.randi_range(0, 1900) # Sets the initial x-coordinate of this instance of 
															  # Enemy2 via a bounded int number generator.
		rng.randomize()										  
															
		enemy2_array[n].position.y = rng.randi_range(0, 1000) # Sets the initial y-coordinate of this instance of 
															  # Enemy2 via a bounded int number generator.
															
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#pass
	for n in total_num_enemies1:
		# Print statements to be used for testing purposes ONLY. Delete before final release.
		#print(n)
		#print(enemy1_array[n])
		
		if enemy1_array[n] != null: # If this instance of Enemy1 has not yet been defeated...
			if (player_light_area.overlaps_body(enemy1_array[n]) and 
				PlayerLightEnabled.isLightEnabled): # If this instance of Enemy1 is in the player's light and the light is on...
				enemy1_array[n].is_in_light = true
			else:
				enemy1_array[n].is_in_light = false
			
			if enemy1_array[n].health == 0: # If this instance of Enemy1's health reaches 0...
				enemy1_array[n].queue_free()# ...Delete this instance of Enemy1...
				enemy1_array.remove(n) 		# ...Remove this entry of the array...
				enemy1_array.insert(n, null)# ...And replace it with a null value.
	
	for n in total_num_enemies2:
		# Print statements to be used for testing purposes ONLY. Delete before final release.
		#print(n)
		#print(enemy2_array[n])
		
		if enemy2_array[n] != null: # If this instance of Enemy2 has not yet been defeated...
			if (player_light_area.overlaps_body(enemy2_array[n]) and 
				PlayerLightEnabled.isLightEnabled): # If this instance of Enemy2 is in the player's light and the light is on...
				enemy2_array[n].is_in_light = true
			else:
				enemy2_array[n].is_in_light = false
			
			if enemy2_array[n].health == 0: # If this instance of Enemy2's health reaches 0...
				enemy2_array[n].queue_free()# ...Delete this instance of Enemy2...
				enemy2_array.remove(n) 		# ...Remove this entry of the array...
				enemy2_array.insert(n, null)# ...And replace it with a null value.
				
# Called every frame. 'delta' is the elapsed time since the previous frame. Physics is synced up with framerate.
func _physics_process(delta):
	pass
	
	# WARNING: This section is a WIP. User caution is advised.
	#var result = space_state.intersect_ray(player.global_position, enemy1.global_position)
	#print(result)
	#if (not result.collider_id == 1327):
	#	enemy1.is_in_light = false

extends Node2D

var Enemy1 = load("res://Enemy1.tscn") # Creates Enemy1 resource as a shortcut to Enemy1 scene.

var enemy1_array = get_tree().get_nodes_in_group("Enemies1") # Stores all enemies in the level (Enemy1)

var total_num_enemies1 = 2 # Number of enemies in the scene

var space_state # See comments on lines 14-15 for info
#onready var player = get_node("Player") # Fetches the player node from the given NodePath.
onready var player_light_area = get_node("Player/Light2D/Area2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
	#space_state = get_world_2d().direct_space_state # Direct access to the level's physics state. 
													# Used for detecting collisions.
																										
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#pass
	for n in enemy1_array.count():
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

# Called every frame. 'delta' is the elapsed time since the previous frame. Physics is synced up with framerate.
func _physics_process(delta):
	pass

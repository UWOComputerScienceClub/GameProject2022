extends KinematicBody2D

export var speed = 70 # How fast the enemy will move (pixels/sec).

var max_health = 100 # Starting health of enemy.
var health = max_health

var is_in_light = false

var velocity = Vector2()
onready var player = get_parent().get_node("Player")
onready var playerLight = get_parent().get_node("Player/Light2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _process(delta):
	# Print statements to be used for testing purposes ONLY. Delete before final release.
	#print(health)
	#print(is_in_light)
	
	$HealthDisplay.update_healthbar(health)
	
	if (is_in_light and 
		PlayerLightEnabled.isLightEnabled and 
		health > 0
		): 			# If enemy is in player's light and flashlight is on and the enemy's health is above 0...
		health -= 1 # Decrement enemy health by 1.

	if PlayerLightEnabled.isLightEnabled: # Move only when player's light is on.
		if player.position.x > position.x:
			position.x -= 1
		if player.position.x < position.x:
			position.x += 1
		if player.position.y > position.y:
			position.y -= 1
		if player.position.y < position.y:
			position.y += 1

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta) # Collide with objects around enemy (e.g. walls).

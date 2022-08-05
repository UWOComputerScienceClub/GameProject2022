extends KinematicBody2D

export var speed = 50 # How fast the enemy will move (pixels/sec).
var screen_size # Size of the game window.

var max_health = 100
var health = 100

var is_in_light = false

var velocity = Vector2()
onready var player = get_parent().get_node("Player")
onready var playerLight = get_parent().get_node("Player/Light2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
func _process(delta):
	#print(health)
	#print(is_in_light)
	
	$HealthDisplay.update_healthbar(health)
	
	if (is_in_light and 
		PlayerLightEnabled.isLightEnabled and 
		health > 0
		):
		health -= 1

	if health > 0:
		if PlayerLightEnabled.isLightEnabled:
			if player.position.x > position.x:
				position.x += 1
			if player.position.x < position.x:
				position.x -= 1
			if player.position.y > position.y:
				position.y += 1
			if player.position.y < position.y:
				position.y -= 1
				
		position.x = clamp(position.x, 0, screen_size.x)
		position.y = clamp(position.y, 0, screen_size.y)
	elif health == 0:
		self.queue_free()

extends KinematicBody2D

export var speed = 50 # How fast the enemy will move (pixels/sec).
var screen_size # Size of the game window.

var health = 100

var is_in_light = false

var velocity = Vector2()
onready var player = get_parent().get_node("Player")
onready var playerLight = get_parent().get_node("Player/Light2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	player.connect("light_body_entered", self, "_on_light_body_entered")
	player.connect("light_body_exited", self, "_on_light_body_exited")

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
func _process(delta):
	print(health)
	
	if is_in_light and PlayerLightEnabled.isLightEnabled and health > 0:
		health -= 1
	
	velocity = Vector2.ZERO # The enemy's movement vector.
	if health > 0:
		if PlayerLightEnabled.isLightEnabled:
			if player.position.x > position.x:
				velocity.x += 1
			if player.position.x < position.x:
				velocity.x -= 1
			if player.position.y > position.y:
				velocity.y += 1
			if player.position.y < position.y:
				velocity.y -= 1

			if velocity.length() > 0:
				velocity = velocity.normalized() * speed

		position += velocity * delta
		position.x = clamp(position.x, 0, screen_size.x)
		position.y = clamp(position.y, 0, screen_size.y)
	elif health == 0:
		self.queue_free()

func _on_light_body_entered():
	is_in_light = true
	
func _on_light_body_exited():
	is_in_light = false

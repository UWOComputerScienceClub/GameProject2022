extends KinematicBody2D

signal light_body_entered
signal light_body_exited

export var speed = 75 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var velocity = Vector2()
onready var enemy = get_parent().get_node("Enemy1")

func _physics_process(delta):
	look_at(get_global_mouse_position()) 
	var collision = move_and_collide(velocity * delta)
	if collision and collision.collider_velocity != Vector2(0,0):
		position.x = 872
		position.y = 496

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("sprint_toggle"):
		speed = 150
	else:
		speed = 75
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func _on_Area2D_body_entered(body):
	emit_signal("light_body_entered")


func _on_Area2D_body_exited(body):
	emit_signal("light_body_exited")

extends Node2D

var Enemy1 = load("res://Enemy1.tscn")
var enemy1 = Enemy1.instance()
var space_state
onready var player = get_node("Player")
# Called when the node enters the scene tree for the first time.
func _ready():
	space_state = get_world_2d().direct_space_state
	add_child(enemy1)
	enemy1.position.x = 1100
	enemy1.position.y = 300
	#pass # Replace with function body.

func _process(delta):
	#pass
	if has_node("Enemy1"):
		if (get_node("Player/Light2D/Area2D").overlaps_body(enemy1) and 
			PlayerLightEnabled.isLightEnabled):
			enemy1.is_in_light = true
		else:
			enemy1.is_in_light = false

func _physics_process(delta):
	pass
	#var result = space_state.intersect_ray(player.global_position, enemy1.global_position)
	#print(result)
	#if (not result.collider_id == 1327):
	#	enemy1.is_in_light = false

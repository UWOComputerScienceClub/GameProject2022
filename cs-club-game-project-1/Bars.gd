extends StaticBody2D

# It's a wall.

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func isWall(): # wull
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(PlayerLightEnabled.hasFlashlight):
		queue_free()

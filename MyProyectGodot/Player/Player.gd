extends KinematicBody2D

const speed = 160 # Pixels/second

func _physics_process(delta):
	var motion = Vector2()
	
	if (Input.is_action_pressed("move_left")):
		motion += Vector2(-1, 0)
	if (Input.is_action_pressed("move_right")):
		motion += Vector2(1, 0)
	
	motion = motion.normalized()*speed*delta
	move_and_collide(motion)

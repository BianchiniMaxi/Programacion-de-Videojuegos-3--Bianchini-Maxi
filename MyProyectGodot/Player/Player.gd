extends KinematicBody2D

export (int) var run_speed = 400
export (int) var jump_speed = -600
export (int) var gravity = 1300
export (ImageTexture) var newTexture

var velocity = Vector2()
var jumping = false


func player_position():
	if position.y > 100:
		position.y = -65
		position.x = -380
	

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var jump = Input.is_action_just_pressed("ui_accept")
	var change_player = Input.is_action_just_pressed("ui_up")
	
	velocity.x += run_speed
	
	if jump and is_on_floor():
		jumping = true
		velocity.y = jump_speed
	if right:
		velocity.x += 200
	if left:
		velocity.x -= 200
	
	if change_player:
		$Sprite.texture = newTexture

func _physics_process(delta):
	get_input()
	player_position()
	
	velocity.y += gravity * delta
	if jumping and is_on_floor():
		jumping = false
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	

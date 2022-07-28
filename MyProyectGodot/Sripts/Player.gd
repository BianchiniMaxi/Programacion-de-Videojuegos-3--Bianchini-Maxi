extends KinematicBody2D

export (int) var gravity = 1300
export (int) var run_speed = 400
export (int) var jump_speed = -600

export (StreamTexture) var texture1
export (StreamTexture) var texture2
export (StreamTexture) var texture3

var lives = 3
var velocity = Vector2()

var start = false
var acelerate = false 

func lives_controller():
	lives -= 1
	if lives == 0:
		get_parent().player_die = true

func player_position():
	if position.y > 300:
		position.y = -100
		position.x = 200
		lives_controller()

func get_input():
	velocity.x = 0
	velocity.x += run_speed
	
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			velocity.y = jump_speed
	
	if Input.is_action_pressed('ui_right') and acelerate:
		velocity.x += 200
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 200
	
	if Input.is_action_just_pressed("ui_number_1"):
		$Sprite.texture = texture1
		acelerate = false
		jump_speed = -600
	if Input.is_action_just_pressed("ui_number_2"):
		$Sprite.texture = texture2
		acelerate = false
		jump_speed = -900
	if Input.is_action_just_pressed("ui_number_3"):
		$Sprite.texture = texture3
		acelerate = true
		jump_speed = -600

func _physics_process(delta):
	
	if Input.is_action_just_pressed("ui_accept"):
		start = true
	
	if(get_slide_collision(get_slide_count() - 1) != null):
		var obj_colition = get_slide_collision(get_slide_count() - 1).collider
		if(obj_colition.is_in_group("Pinches")):
			position.x = 200
			lives_controller()
	
	#if start:
	get_input()
	player_position()
		
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2(0, -1))
	

extends KinematicBody2D

export (int) var gravity = 1300
export (int) var run_speed = 400
export (int) var jump_speed = -600

export (StreamTexture) var texture1
export (StreamTexture) var texture2
export (StreamTexture) var texture3

var velocity = Vector2()

var acelerate = false 
var jumping = false
var jumpx2 = false

func player_position():
	if position.y > 100:
		position.y = -65
		position.x = -380

func get_input():
	velocity.x = 0
	velocity.x += run_speed
	
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = jump_speed
			jumping = true
		else:
			if jumping and jumpx2:
				velocity.y = jump_speed
				jumping = false
	
	if Input.is_action_pressed('ui_right') and acelerate:
		velocity.x += 200
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 200
	
	if Input.is_action_just_pressed("ui_number_1"):
		$Sprite.texture = texture1
		jumpx2 = false
		acelerate = false
	if Input.is_action_just_pressed("ui_number_2"):
		$Sprite.texture = texture2
		jumpx2 = true
		acelerate = false
	if Input.is_action_just_pressed("ui_number_3"):
		$Sprite.texture = texture3
		jumpx2 = false
		acelerate = true
		

func _physics_process(delta):
	get_input()
	player_position()
	
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	


func _on_Area2D_body_entered(body):
	get_tree().change_scene("res://Levels/Menu.tscn")

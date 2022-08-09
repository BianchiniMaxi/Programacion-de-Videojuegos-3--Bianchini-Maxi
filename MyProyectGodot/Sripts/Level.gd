extends Node2D

export (bool) var coin
export (bool) var player_die
export (String) var nextLevel
export (PackedScene) var Life

var list_lives = []
var offset_lifes = 80
var lives = 3
var points = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	create_life()
	

func _physics_process(delta):
	get_input()
	
	if player_die:
		get_tree().change_scene("res://Scenes/Menu.tscn")
	if coin:
		points += 15
		coin = false
		

func get_input():
	if Input.is_action_just_pressed("ui_restart"):
		get_tree().reload_current_scene()

func _on_Area2D_body_entered(_body):
	get_tree().change_scene(nextLevel)
	

func create_life():
	for i in 3:
		var newLife = Life.instance()
		get_tree().get_nodes_in_group("Gui")[0].add_child(newLife)
		newLife.global_position.x += offset_lifes * i
		list_lives.append(newLife)
		
func delete_life():
	lives -= 1
	list_lives[lives].queue_free()


extends Node2D

export (bool) var coin
export (bool) var player_die
export (String) var nextLevel
export (PackedScene) var Life

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
	for i in lives:
		var newLife = Life.instance()
		get_tree().get_nodes_in_group("Gui")[0].add_child(newLife)


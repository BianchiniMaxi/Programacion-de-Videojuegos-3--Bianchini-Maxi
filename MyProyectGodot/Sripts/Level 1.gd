extends Node2D
export (bool) var player_die
export (bool) var coin

var points = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if player_die:
		get_tree().change_scene("res://Scenes/Menu.tscn")
	if coin:
		points += 15
		coin = false

func _on_Area2D_body_entered(_body):
	get_tree().change_scene("res://Scenes/Level 2.tscn")

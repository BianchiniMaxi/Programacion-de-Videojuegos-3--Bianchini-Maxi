extends Node

# Declare member variables here. Examples:
var puntos = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func actualizar_puntos():
	get_tree().get_nodes_in_group("Puntos")[0].text = String(puntos)

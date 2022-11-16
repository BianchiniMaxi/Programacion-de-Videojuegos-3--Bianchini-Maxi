extends Node

var puntos

func actualizar_puntos():
	get_tree().get_nodes_in_group("Puntos")[0].text = String(puntos)

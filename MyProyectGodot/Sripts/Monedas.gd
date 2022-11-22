extends Area2D

signal agarrar_moneda

#SI COLISIONA CON UN OBJETO DENTRO DEL GRUPO "jUGADOR"
func _on_Moneda_body_entered(body):
	if body.is_in_group("Jugador"):
		get_tree().get_nodes_in_group("SFX")[0].get_node("Moneda").play()
		emit_signal("agarrar_moneda")
		queue_free()
		

extends Area2D

func _on_Moneda_body_entered(body):
	if body.is_in_group("Jugador"):
		get_tree().get_nodes_in_group("SFX")[0].get_node("Audio_moneda").play()
		get_parent().get_parent().agarrar_moneda()
		get_parent().get_parent().crear_monedas()
		queue_free()

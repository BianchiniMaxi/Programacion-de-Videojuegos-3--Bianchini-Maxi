extends Area2D

func _on_Moneda_body_entered(body):
	if body.is_in_group("Jugador"):
		get_parent().get_parent().agarrar_moneda()
		queue_free()

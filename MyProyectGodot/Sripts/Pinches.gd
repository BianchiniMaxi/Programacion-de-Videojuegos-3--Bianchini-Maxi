extends Area2D

func _on_Pinche_body_entered(body):
	if body.is_in_group("Jugador") && body.muerto == false:
		body.muerto = true
		

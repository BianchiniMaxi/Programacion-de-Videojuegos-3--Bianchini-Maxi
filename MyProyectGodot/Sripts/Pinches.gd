extends Area2D

#QUITA UNA VIDA SI COLISIONA CON UN OBJETO QUE ESTA DENTRO DEL GRUPO "JUGADOR"
func _on_Pinche_body_entered(body):
	if body.is_in_group("Jugador"):
		body.morir()
		

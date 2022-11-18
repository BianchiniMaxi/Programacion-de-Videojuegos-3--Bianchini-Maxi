extends Area2D

#SI COLISIONA CON UN OBJETO DENTRO DEL GRUPO "jUGADOR"
func _on_Moneda_body_entered(body):
	if body.is_in_group("Jugador"):
		get_tree().get_nodes_in_group("SFX")[0].get_node("Moneda").play()
		get_parent().get_parent().agarrar_moneda() #AUMENTA EN CONTADOR DE MONEDAS
		get_parent().get_parent().crear_monedas() #AGREGA UNA MONEDA A UI
		queue_free()
		

extends Control

func _on_Boton_Comenzar_pressed():
	get_tree().change_scene("res://Scenes/Nivel 1.tscn")
	Puntos.puntos = 0


func _on_Boton_Instrucciones_pressed():
	$Titulo.visible = false
	$Instrucciones.visible = true


func _on_Boton_Salir_pressed():
	get_tree().quit()


func _on_Boton_Menu_pressed():
	$Titulo.visible = true
	$Instrucciones.visible = false

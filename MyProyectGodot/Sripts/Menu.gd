extends Control

func _ready():
	get_tree().get_nodes_in_group("Music")[0].get_node("Menu").play()

func _on_Boton_Comenzar_pressed():
	#get_tree().get_nodes_in_group("Music")[0].get_node("Intro").stop()
	get_tree().get_nodes_in_group("SFX")[0].get_node("Botones").play()
	get_tree().change_scene("res://Scenes/Nivel 1.tscn")
	Puntos.puntos = 0


func _on_Boton_Instrucciones_pressed():
	get_tree().get_nodes_in_group("SFX")[0].get_node("Botones").play()
	$Titulo.visible = false
	$Instrucciones.visible = true


func _on_Boton_Salir_pressed():
	get_tree().quit()


func _on_Boton_Menu_pressed():
	get_tree().get_nodes_in_group("SFX")[0].get_node("Botones").play()
	$Titulo.visible = true
	$Instrucciones.visible = false

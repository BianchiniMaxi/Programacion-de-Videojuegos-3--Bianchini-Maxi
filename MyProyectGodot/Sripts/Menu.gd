extends Control

func _ready():
	get_tree().get_nodes_in_group("Music")[0].get_node("Menu").play()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_Boton_Comenzar_pressed():
	get_tree().get_nodes_in_group("Music")[0].get_node("Menu").stop()
	get_tree().get_nodes_in_group("SFX")[0].get_node("Botones").play()
	GameData.cargar_partida()
	get_tree().change_scene(GameData.nivel)
	Puntos.puntos = GameData.puntos
	

func _on_Boton_Creditos_pressed():
	get_tree().get_nodes_in_group("SFX")[0].get_node("Botones").play()
	$Titulo.visible = false
	$Creditos.visible = true
	

func _on_Boton_Salir_pressed():
	get_tree().quit()
	

func _on_Boton_Menu_pressed():
	get_tree().get_nodes_in_group("SFX")[0].get_node("Botones").play()
	$Titulo.visible = true
	$Creditos.visible = false
	

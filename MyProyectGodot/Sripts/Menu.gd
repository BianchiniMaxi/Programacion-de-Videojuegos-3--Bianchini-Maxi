extends Control

func _ready():
	
	get_tree().get_nodes_in_group("Music")[0].get_node("Menu").play() #REPRODUCIMOS LA MUSICA DEL MENU
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) #HACEMOS EL CURSOL VISIBLE
	
	#REVISAMOS SI HAY UNA PARTIDA GUARDADA. SI LA HAY MOSTRAMOS UN MENU CON EL BOTON QUE PERMITE SEGUIR ESA PARTIDA, SI NO ESE BOTON NO ESTA
	GameData.cargar_partida()
	if (GameData.nivel == "res://Scenes/Nivel 1.tscn"):
		$Titulo.get_child(0).visible = true
	else:
		$Titulo.get_child(1).visible = true
	
	$Titulo.get_child(2).get_child(0).text = String(GameData.mayor_puntaje) #CARGAMOS EL MAYOR PUNTAJE PARA MOSTRARLO EN EL MENU
	

#CARGA UNA PARTIDA NUEVA
func _on_Boton_Comenzar_pressed():
	get_tree().get_nodes_in_group("Music")[0].get_node("Menu").stop()
	get_tree().get_nodes_in_group("SFX")[0].get_node("Botones").play()
	
	GameData.puntos = 0
	GameData.nivel = "res://Scenes/Nivel 1.tscn"
	GameData.tutorial_realizado = false
	GameData.guardar_partida()
	
	get_tree().change_scene(GameData.nivel)
	

#CARGA EL MENU DE LOS CREDITOS
func _on_Boton_Creditos_pressed():
	get_tree().get_nodes_in_group("SFX")[0].get_node("Botones").play()
	$Titulo.visible = false
	$Creditos.visible = true
	

#SALE DEL JUEGO
func _on_Boton_Salir_pressed():
	get_tree().quit()
	

#VUELVE AL MENU DESDE EL MENU CREDITOS
func _on_Boton_Menu_pressed():
	get_tree().get_nodes_in_group("SFX")[0].get_node("Botones").play()
	$Titulo.visible = true
	$Creditos.visible = false
	

#CARGA LA PARTIDA GUARDADA
func _on_Boton_Continuar_Partida_pressed():
	get_tree().get_nodes_in_group("Music")[0].get_node("Menu").stop()
	get_tree().get_nodes_in_group("SFX")[0].get_node("Botones").play()
	get_tree().change_scene(GameData.nivel)
	

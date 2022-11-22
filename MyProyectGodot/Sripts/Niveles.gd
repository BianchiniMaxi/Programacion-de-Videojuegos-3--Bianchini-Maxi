extends Node2D

#VARIALBES VARIAS EXPORTADAS PARA SSER MODIFICADAS DESDE EL EDITOR
export (String) var siguiente_nivel
export (PackedScene) var Corazones
export (PackedScene) var Monedas
export (String) var nivel_actual
export (float) var vidas 

#VARIABLES VARIAS
var arreglo_de_instrucciones
var contador_instrucciones
var diferencia_corazones
var diferencia_monedas
var cantidad_monedas
var menu_activo
var lista_vidas
var monedas

#INICIALIZACION DE LAS VARIABLES
func _ready():
	
	get_tree().get_nodes_in_group("Music")[0].get_node("Gameplay").play()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN) #OCULTAMOS EL PUNTERO DEL MOUSE
	
	#INICIALIZACION DE VARIABLES
	arreglo_de_instrucciones =  [false,false,false,false,false]
	contador_instrucciones = 0
	diferencia_corazones = 80
	diferencia_monedas = 50
	cantidad_monedas = 0
	menu_activo = false
	lista_vidas = []
	monedas = 0
	
	crear_vidas()
	

func _physics_process(_delta):
	
	get_input()
	
	if vidas <= 0 && !menu_activo:
		menu_muerte()
		

#INPUTS DEL JUGADOR
func get_input():
	if Input.is_action_just_pressed("ui_pause"): #MENU DE PAUSA ACTIVAR Y DESACTIVAR
		if !menu_activo:
			$"POP UPs"/PopupPanel.popup()
			$"POP UPs"/PopupPanel.get_child(2).visible = true
			$"Blur".environment.dof_blur_near_enabled = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			$Jugador.parar_jugador(true,false)
			menu_activo = true
		else:
			if $"POP UPs"/PopupPanel.get_child(2).visible:
				$"POP UPs"/PopupPanel.get_child(2).visible = false
				$"Blur".environment.dof_blur_near_enabled = false
				Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
				$Jugador.parar_jugador(false,false)
				menu_activo = false
			
	
	#PERMITE VOVLER A JUGAR O PASAR AL SIGUIENTE NIVEL CON LA BARRA ESPACIADORA, SOLO AL ESTAR DENTRO DE LOS MENUS DE GANAR O PERDER
	if Input.is_action_just_pressed("ui_jump") && $"POP UPs"/PopupPanel.get_child(1).visible:
			get_tree().get_nodes_in_group("Music")[0].get_node("Gameplay").stop()
			get_tree().get_nodes_in_group("SFX")[0].get_node("Botones").play()
			$"Blur".environment.dof_blur_near_enabled = false
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			get_tree().change_scene(nivel_actual)
	else:
		if Input.is_action_just_pressed("ui_jump") && $"POP UPs"/PopupPanel.get_child(0).visible:
				get_tree().get_nodes_in_group("Music")[0].get_node("Gameplay").stop()
				get_tree().get_nodes_in_group("SFX")[0].get_node("Botones").play()
				Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
				get_tree().change_scene(siguiente_nivel)
		
	

#AUMENTA EL CONTADOR DE LAS MONEDAS
func agarrar_moneda():
	monedas += 1

#ACTIVA EL MENU DE MUERTE
func menu_muerte():
	$"POP UPs"/PopupPanel.popup()
	$"POP UPs"/PopupPanel.get_child(0).visible = false
	$"POP UPs"/PopupPanel.get_child(1).visible = true
	$"Blur".environment.dof_blur_near_enabled = true #ACTIVA EL BLUR QUE SE USA EN LOS DISTINTOS MENUS DEL GAMEPLAY
	menu_activo = true
	
	get_tree().get_nodes_in_group("Music")[0].get_node("Gameplay").stop()
	get_tree().get_nodes_in_group("Music")[0].get_node("Menu").play()
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Jugador.parar_jugador(true,false) #FRENA AL JUGADOR
	

#ACTIVA EL MENU DE VICTORIA
func _on_Bandera_Final_body_entered(body):
	if body.is_in_group("Jugador"):
		$"POP UPs"/PopupPanel.popup()
		$"POP UPs"/PopupPanel.get_child(0).visible = true
		$"POP UPs"/PopupPanel.get_child(1).visible = false
		$"Blur".environment.dof_blur_near_enabled = true
		menu_activo = true
		
		get_tree().get_nodes_in_group("Music")[0].get_node("Gameplay").stop()
		get_tree().get_nodes_in_group("SFX")[0].get_node("WinLevel").play()
		get_tree().get_nodes_in_group("Music")[0].get_node("Menu").play()
		
		
		GameData.puntos += 150 + ((30 * monedas) + (30 * vidas) ) #CALCULA LOS PUNTOS OBTENIDOS
		GameData.actualizar_puntos()
		
		#PASA A GUARDAR LOS DATOS
		#SI EL PROXIMO NIVEL NO ES EL MENU (TERMINO EL JUEGO COMPLETO) GUARDA ESOS DATOS, SI NO LOS ACOMODA PARA QUE PUEDA VOLVER A JUGAR
		if siguiente_nivel != "Scenes/Menu.tscn":
			GameData.nivel = siguiente_nivel
		else:
			GameData.puntos = 0
			GameData.nivel = "res://Scenes/Nivel 1.tscn"
			GameData.tutorial_realizado = false
			
		GameData.comparar_puntajes() #COMPARA LOS PUNTAJES PARA VER SI EL NUEVO PUNTAJE ES EL MAS ALTO
		GameData.guardar_partida() #GUARDA LA PARTIDA
		
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$Jugador.parar_jugador(true,false)
		
	

#CREA LA UI DE LAS MONEDAS UNA VEZ QUE SE CAPTURA UNA NUEVA
func crear_monedas():
	var nueva_moneda = Monedas.instance()
	get_tree().get_nodes_in_group("Gui_Monedas")[0].add_child(nueva_moneda)
	nueva_moneda.global_position.x -= diferencia_monedas * cantidad_monedas
	cantidad_monedas += 1
	

#CREA LA UI DE LAS VIDAS DEPENDIENDO DE LA CANTIDAD QUE TENGA
func crear_vidas():
	for i in vidas:
		var nueva_vida = Corazones.instance()
		get_tree().get_nodes_in_group("Gui_Corazones")[0].add_child(nueva_vida)
		nueva_vida.global_position.x += diferencia_corazones * i
		lista_vidas.append(nueva_vida)
		

#AL PERDER UNA VIDA ESTA DESAPARECE DE LA UI
func perder_vidas():
	vidas -= 1
	contador_instrucciones = 0
	if vidas >= 0:
		lista_vidas[vidas].queue_free()
		

#PASA AL SIGUIENTE NIVEL AL SER PRECIONADO
func _on_Boton_Siguiente_pressed():
	get_tree().get_nodes_in_group("Music")[0].get_node("Gameplay").stop()
	get_tree().get_nodes_in_group("SFX")[0].get_node("Botones").play()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	get_tree().change_scene(siguiente_nivel)
	

#REINICIA EL NIVEL AL SER PRECIONADO
func _on_Boton_Reiniciar_pressed():
	get_tree().get_nodes_in_group("Music")[0].get_node("Gameplay").stop()
	get_tree().get_nodes_in_group("SFX")[0].get_node("Botones").play()
	$"Blur".environment.dof_blur_near_enabled = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	get_tree().change_scene(nivel_actual)
	

#PASA AL MENU DEL JUEGO AL SER PRECIONADO
func _on_Boton_Menu_pressed():
	get_tree().get_nodes_in_group("Music")[0].get_node("Gameplay").stop()
	get_tree().get_nodes_in_group("SFX")[0].get_node("Botones").play()
	get_tree().change_scene("res://Scenes/Menu.tscn")
	

#ACTIVA LOS DIFERENTES TEXTOS DEL TUTORIAL
func _on_Tutorial_body_entered(body):
	if body.is_in_group("Jugador") && !arreglo_de_instrucciones[contador_instrucciones] && !GameData.tutorial_realizado:
		$"POP UPs"/PopupPanel.popup()
		$"POP UPs"/PopupPanel.get_child(contador_instrucciones + 3).visible = true
		arreglo_de_instrucciones[contador_instrucciones] = true
		$Jugador.parar_jugador(true,true)
		menu_activo = true
		
	
	#LLEVA UN CONTEO DE LOS TEXTOS DEL TUTORIAL QUE SE MOSTRARON, PARA NO VOLVERLOS A MOSTRAR
	contador_instrucciones += 1
	if contador_instrucciones >= 5:
		GameData.tutorial_realizado = true
	

#OCULTA LOS TEXTOS DEL TUTORIAL
func ocultar_tutorial():
	$"POP UPs"/PopupPanel.get_child(3).visible = false
	$"POP UPs"/PopupPanel.get_child(4).visible = false
	$"POP UPs"/PopupPanel.get_child(5).visible = false
	$"POP UPs"/PopupPanel.get_child(6).visible = false
	$"POP UPs"/PopupPanel.get_child(7).visible = false
	menu_activo = false
	


func _on_Moneda_agarrar_moneda():
		agarrar_moneda() #AUMENTA EN CONTADOR DE MONEDAS
		crear_monedas() #AGREGA UNA MONEDA A UI
	

func _on_Jugador_perder_vidas():
	perder_vidas()
	

func _on_Jugador_ocultar_tutorial():
	ocultar_tutorial()
	

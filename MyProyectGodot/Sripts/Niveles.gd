extends Node2D

export (String) var siguiente_nivel
export (PackedScene) var Corazones
export (PackedScene) var Monedas
export (String) var nivel_actual
export (float) var vidas 

var arreglo_de_instrucciones
var contador_instrucciones
var diferencia_corazones
var diferencia_monedas
var cantidad_monedas
var menu_activo
var lista_vidas
var monedas

# Called when the node enters the scene tree for the first time.
func _ready():
	
	get_tree().get_nodes_in_group("Music")[0].get_node("Gameplay").play()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	arreglo_de_instrucciones =  [false,false,false,false,false]
	contador_instrucciones = 0
	diferencia_corazones = 80
	diferencia_monedas = 50
	cantidad_monedas = 0
	menu_activo = false
	lista_vidas = []
	monedas = 0
	
	crear_vidas()
	

func agarrar_moneda():
	monedas += 1
	
func getInput():
	if Input.is_action_just_pressed("ui_pause"):
		if !menu_activo:
			$"POP UPs"/PopupPanel.popup()
			$"POP UPs"/PopupPanel.get_child(2).visible = true
			$"Blur".environment.dof_blur_near_enabled = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			$Jugador.pararJugador(true,false)
			menu_activo = true
		else:
			if $"POP UPs"/PopupPanel.get_child(2).visible:
				$"POP UPs"/PopupPanel.get_child(2).visible = false
				$"Blur".environment.dof_blur_near_enabled = false
				Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
				$Jugador.pararJugador(false,false)
				menu_activo = false
	
	if Input.is_action_just_pressed("ui_jump") && $"POP UPs"/PopupPanel.get_child(1).visible:
			get_tree().get_nodes_in_group("Music")[0].get_node("Gameplay").stop()
			get_tree().get_nodes_in_group("SFX")[0].get_node("Botones").play()
			get_tree().change_scene(nivel_actual)
			$"Blur".environment.dof_blur_near_enabled = false
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:
		if Input.is_action_just_pressed("ui_jump") && $"POP UPs"/PopupPanel.get_child(0).visible:
				get_tree().get_nodes_in_group("Music")[0].get_node("Gameplay").stop()
				get_tree().get_nodes_in_group("SFX")[0].get_node("Botones").play()
				get_tree().change_scene(siguiente_nivel)
				Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			
		
	

func _physics_process(_delta):
	
	getInput()
	
	if vidas == 0 && !menu_activo:
		menuMuerte()
		
	

func menuMuerte():
	$"POP UPs"/PopupPanel.popup()
	$"POP UPs"/PopupPanel.get_child(0).visible = false
	$"POP UPs"/PopupPanel.get_child(1).visible = true
	$"Blur".environment.dof_blur_near_enabled = true
	menu_activo = true
	
	get_tree().get_nodes_in_group("Music")[0].get_node("Gameplay").stop()
	get_tree().get_nodes_in_group("Music")[0].get_node("Menu").play()
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Jugador.pararJugador(true,false)
	

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
		
		Puntos.puntos += 150 + ((30 * monedas) + (30 * vidas) ) #VER SI CAMBIO Y LO DIVIDO POR LAS VIDAS PERDIODAS
		Puntos.actualizar_puntos()
		#PONER LA PARTE DE GUARDAR EN UNA FUNCION Y LOS DEMAS SCRIPTS NO DEBERIAN ALTERAR LOS VALORES DE GAMEDATA; SINO USAR UNA FUNCION
		if siguiente_nivel != "Scenes/Menu.tscn":
			GameData.puntos = Puntos.puntos
			GameData.nivel = siguiente_nivel
		else:
			GameData.puntos = 0
			GameData.nivel = "res://Scenes/Nivel 1.tscn"
			GameData.tutorialrealizado = false
			
		GameData.compararPuntajes(Puntos.puntos)
		GameData.guardar_partida()
		
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$Jugador.pararJugador(true,false)
		
	

func crear_monedas():
	var nueva_moneda = Monedas.instance()
	get_tree().get_nodes_in_group("Gui_Monedas")[0].add_child(nueva_moneda)
	nueva_moneda.global_position.x -= diferencia_monedas * cantidad_monedas
	cantidad_monedas += 1
	

func crear_vidas():
	for i in vidas:
		var nueva_vida = Corazones.instance()
		get_tree().get_nodes_in_group("Gui_Corazones")[0].add_child(nueva_vida)
		nueva_vida.global_position.x += diferencia_corazones * i
		lista_vidas.append(nueva_vida)
		

func perder_vidas():
	vidas -= 1
	contador_instrucciones = 0
	if vidas >= 0:
		lista_vidas[vidas].queue_free()
		

# Menu si GANA
func _on_Boton_Siguiente_pressed():
	get_tree().get_nodes_in_group("Music")[0].get_node("Gameplay").stop()
	get_tree().get_nodes_in_group("SFX")[0].get_node("Botones").play()
	get_tree().change_scene(siguiente_nivel)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	

# Menu si PIERDE
func _on_Boton_Reiniciar_pressed():
	get_tree().get_nodes_in_group("Music")[0].get_node("Gameplay").stop()
	get_tree().get_nodes_in_group("SFX")[0].get_node("Botones").play()
	get_tree().change_scene(nivel_actual)
	$"Blur".environment.dof_blur_near_enabled = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	

func _on_Boton_Menu_pressed():
	get_tree().get_nodes_in_group("Music")[0].get_node("Gameplay").stop()
	get_tree().get_nodes_in_group("SFX")[0].get_node("Botones").play()
	get_tree().change_scene("res://Scenes/Menu.tscn")
	

func _on_Tutorial_body_entered(body):
	if body.is_in_group("Jugador") && !arreglo_de_instrucciones[contador_instrucciones] && !GameData.tutorialrealizado:
		$"POP UPs"/PopupPanel.popup()
		$"POP UPs"/PopupPanel.get_child(contador_instrucciones + 3).visible = true
		arreglo_de_instrucciones[contador_instrucciones] = true
		$Jugador.pararJugador(true,true)
		menu_activo = true
		
	contador_instrucciones += 1
	if contador_instrucciones >= 5:
		GameData.tutorialrealizado = true
	

func ocultar_tutorial():
	$"POP UPs"/PopupPanel.get_child(3).visible = false
	$"POP UPs"/PopupPanel.get_child(4).visible = false
	$"POP UPs"/PopupPanel.get_child(5).visible = false
	$"POP UPs"/PopupPanel.get_child(6).visible = false
	$"POP UPs"/PopupPanel.get_child(7).visible = false
	menu_activo = false
	

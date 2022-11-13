extends Node2D

export (String) var siguiente_nivel
export (PackedScene) var Corazones
export (PackedScene) var Monedas
export (String) var nivel_actual
export (float) var vidas 

var diferencia_corazones = 80
var diferencia_monedas = 50
var cantidad_monedas = 0
var menu_perdio = false
var lista_vidas = []
var monedas = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	crear_vidas()
	get_tree().get_nodes_in_group("Music")[0].get_node("Gameplay").play()
	

func agarrar_moneda():
	monedas += 1
	

func _physics_process(_delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://Scenes/Menu.tscn")
	
	if vidas == 0 && menu_perdio != true:
		$"POP UPs"/PopupPanel.popup()
		$"POP UPs"/PopupPanel.get_child(0).get_child(0).visible = false
		$"POP UPs"/PopupPanel.get_child(0).get_child(1).visible = true
		get_tree().get_nodes_in_group("Music")[0].get_node("Gameplay").stop()
		get_tree().get_nodes_in_group("Music")[0].get_node("Menu").play()
		$Jugador.pararJugador()
		menu_perdio = true
		

func _on_Bandera_Final_body_entered(body):
	if body.is_in_group("Jugador"):
		$"POP UPs"/PopupPanel.popup()
		$"POP UPs"/PopupPanel.get_child(0).get_child(0).visible = true
		$"POP UPs"/PopupPanel.get_child(0).get_child(1).visible = false
		$Jugador.pararJugador()
		get_tree().get_nodes_in_group("Music")[0].get_node("Gameplay").stop()
		get_tree().get_nodes_in_group("SFX")[0].get_node("WinLevel").play()
		get_tree().get_nodes_in_group("Music")[0].get_node("Menu").play()
		
		Puntos.puntos += 150 + ((30 * monedas) + (30 * vidas) ) #VER SI CAMBIO Y LO DIVIDO POR LAS VIDAS PERDIODAS
		Puntos.actualizar_puntos()
		

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
	if vidas >= 0:
		lista_vidas[vidas].queue_free()
		

# Menu si GANA
func _on_Boton_Siguiente_pressed():
	get_tree().get_nodes_in_group("Music")[0].get_node("Gameplay").stop()
	get_tree().get_nodes_in_group("SFX")[0].get_node("Botones").play()
	get_tree().change_scene(siguiente_nivel)
	

# Menu si PIERDE
func _on_Boton_Reiniciar_pressed():
	get_tree().get_nodes_in_group("Music")[0].get_node("Gameplay").stop()
	get_tree().get_nodes_in_group("SFX")[0].get_node("Botones").play()
	get_tree().change_scene(nivel_actual)
	

func _on_Boton_Menu_pressed():
	get_tree().get_nodes_in_group("Music")[0].get_node("Gameplay").stop()
	get_tree().get_nodes_in_group("SFX")[0].get_node("Botones").play()
	get_tree().change_scene("res://Scenes/Menu.tscn")
	

func _on_Boton_Salir_pressed():
	get_tree().quit()
	

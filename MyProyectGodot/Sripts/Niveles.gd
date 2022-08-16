extends Node2D

export (String) var siguiente_nivel
export (String) var nivel_actual
export (PackedScene) var Corazones

var lista_vidas = []
var diferencia_corazones = 80
var vidas = 3
var puntos = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	crear_vidas()
	

func agarrar_moneda():
	puntos += 15

func _physics_process(delta):
	get_input()
	
	if vidas == 0:
		get_tree().change_scene("res://Scenes/Menu.tscn")
	

func get_input():
	if Input.is_action_just_pressed("ui_restart"):
		get_tree().reload_current_scene()

func _on_Bandera_Final_body_entered(body):
	if body.is_in_group("Jugador"):
		$PopupPanel.popup()
		#get_tree().paused = true

func crear_vidas():
	for i in 3:
		var nueva_vida = Corazones.instance()
		get_tree().get_nodes_in_group("Gui")[0].add_child(nueva_vida)
		nueva_vida.global_position.x += diferencia_corazones * i
		lista_vidas.append(nueva_vida)
	

func perder_vidas():
	vidas -= 1
	lista_vidas[vidas].queue_free()


func _on_BotonSiguiente_pressed():
	get_tree().paused = false
	get_tree().change_scene(siguiente_nivel)

		

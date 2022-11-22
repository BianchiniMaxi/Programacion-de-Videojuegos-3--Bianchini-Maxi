extends KinematicBody2D

#VARIALBES VARIAS EXPORTADAS PARA SSER MODIFICADAS DESDE EL EDITOR
export (int) var velocidad_correr
export (int) var fuerza_salto
export (int) var gravedad

export (StreamTexture) var textura1
export (StreamTexture) var textura2
export (StreamTexture) var textura3

#VARIABLES VARIAS
var frenado_por_tutorial
var tiempo_tutorial
var tutorial_activo
var permitir_muerte
var menu_activo
var velocidad
var salto

signal perder_vidas
signal ocultar_tutorial

#INICIALIZAMOS LAS VARIABLES
func _ready():
	velocidad_correr = 600
	fuerza_salto = -850
	gravedad = 2200
	
	frenado_por_tutorial = false
	tutorial_activo = false
	menu_activo = false
	salto = false
	
	velocidad = Vector2()
	
	tiempo_tutorial = 0
	permitir_muerte = 0
	
	#$Jugador/Particles2D.position.x = 17
	#$Jugador/Particles2D.scale = Vector2(1,1)
	

func _physics_process(_delta):
	if menu_activo != true:
		
		get_input()
		
		permitir_muerte += _delta
		#if is_on_floor():
			#$Jugador/Particles2D.emitting = true
		
		#APLICAMOS MAS GRAVEDAD CUANDO EL PRESONAJE ESTA CAYENDO
		if salto && velocidad.y >= 0:
			gravedad = 4000
			salto = false
		
		#APLICAMOS LAS FISICAS
		velocidad.x = velocidad_correr
		velocidad.y += gravedad * _delta
		velocidad = move_and_slide(velocidad, Vector2(0, -1))
	else:
		#SI HAY TUTORIAL LE TOMAMOS UN TIEMPO PARA VOLVER A PERMITIR QUE EL JUGADOR SE MUEVA NUEVAMENTE
		if tutorial_activo:
			tiempo_tutorial += _delta
			if tiempo_tutorial >= 6:
				activar_jugador()
	

#LO LLEVA AL INICIO DEL MAPA Y LE RESTA LA VIDA PERDIDA
func posicion_inicial():
		position.x = 200
		position.y = -100
		permitir_muerte = 0
		emit_signal("perder_vidas")
	

#INPUTS DEL JUGADOR
func get_input():
	
	if Input.is_action_pressed("ui_jump"):
		if is_on_floor():
			velocidad.y += fuerza_salto
			gravedad = 2200
			salto = true
			$Jugador/Particles2D.emitting = false
	
	if Input.is_action_pressed("ui_number_1"): 
		$Sprite.texture = textura1
		velocidad_correr = 600
		fuerza_salto = -850
		
	if Input.is_action_pressed("ui_number_2"):
		$Sprite.texture = textura2
		velocidad_correr = 600
		fuerza_salto = -1400
		
	if Input.is_action_pressed("ui_number_3"): 
		$Sprite.texture = textura3
		velocidad_correr = 800
		fuerza_salto = -850
	

#PERMITIMOS EL MOVIMIENTO DEL PERSONAJE Y OCULTAMOS EL TEXTO DEL TUTORIAL
func activar_jugador():
	tiempo_tutorial = 0
	parar_jugador(false,false)
	tutorial_activo = false
	emit_signal("ocultar_tutorial") 
	

#DETENEMOS AL JUGADOR YA SEA QUE PUSO PAUSA O ENTRO EN ALGUNO DE LOS MENUS
func parar_jugador(menu,tutorial):
	menu_activo = menu
	tutorial_activo = tutorial
	

#SI COLISIONA CON EL MAPA LE DECIMOS QUE MUERA
func _on_Collision_Cuerpo_body_entered(body):
	if body.is_in_group("Mapa"): 
		morir()
	

func morir():
	#SI MUERE REPROUCIMOS EL SONIDO Y LO LLEVAMOS AL INICIO DEL MAPA
	if permitir_muerte > 1:
		get_tree().get_nodes_in_group("SFX")[0].get_node("Muerte").play()
		posicion_inicial()

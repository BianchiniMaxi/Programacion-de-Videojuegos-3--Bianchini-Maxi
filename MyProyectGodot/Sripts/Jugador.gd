extends KinematicBody2D

export (int) var velocidad_correr
export (int) var fuerza_salto
export (int) var gravedad

export (StreamTexture) var textura1
export (StreamTexture) var textura2
export (StreamTexture) var textura3

var frenado_por_tutorial
var tiempo_tutorial
var tutorial_activo
var menu_activo
var velocidad
var muerto
var salto

func _ready():
	velocidad_correr = 600
	fuerza_salto = -850
	gravedad = 2200
	
	frenado_por_tutorial = false
	tutorial_activo = false
	menu_activo = false
	muerto = false
	salto = false
	
	velocidad = Vector2()
	
	tiempo_tutorial = 0
	

func _physics_process(_delta):
	if menu_activo != true:
		
		get_input()
		
		if salto && velocidad.y >= 0:
			gravedad = 4000
			salto = false
	
		if muerto == true:
			get_tree().get_nodes_in_group("SFX")[0].get_node("Muerte").play()
			posicion_inicial()
		
		velocidad.x = velocidad_correr
		velocidad.y += gravedad * _delta
		velocidad = move_and_slide(velocidad, Vector2(0, -1))
	else:
		if tutorial_activo:
			tiempo_tutorial += _delta
			if tiempo_tutorial >= 6:
				activar_jugador()
	

func posicion_inicial():
	muerto = false
	position.x = 200
	position.y = -100
	get_parent().perder_vidas()
	

func get_input():
	
	if Input.is_action_pressed("ui_jump"):
		if is_on_floor():
			velocidad.y += fuerza_salto
			gravedad = 2200
			salto = true
	
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
	

func activar_jugador():
	tiempo_tutorial = 0
	parar_pugador(false,false)
	tutorial_activo = false
	get_parent().ocultar_tutorial()
	

func parar_pugador(menu,tutorial):
	menu_activo = menu
	tutorial_activo = tutorial
	

func _on_Collision_Cuerpo_body_entered(body):
	if body.is_in_group("Mapa") && muerto == false: 
		muerto = true
	

extends KinematicBody2D

export (int) var gravedad = 2200
export (int) var velocidad_correr = 600
export (int) var fuerza_salto = -850

export (StreamTexture) var textura1
export (StreamTexture) var textura2
export (StreamTexture) var textura3

var velocidad = Vector2()
var muerto = false
var personajeSkin = 1
var tiempo_puede_morir = 0
var salto = false

func posicion_inicial():
	muerto = false
	position.y = -100
	position.x = 200
	get_parent().perder_vidas()
	

func get_input():
	velocidad.x = 0
	velocidad.x += velocidad_correr
	
	if Input.is_action_just_pressed("ui_jump"):
		if is_on_floor():
			gravedad = 2200
			velocidad.y = fuerza_salto
			salto = true
	
	if Input.is_action_just_pressed("ui_number_1"): #&& personajeSkin != 1:
		#get_parent().modificar_numero_cambios()
		$Sprite.texture = textura1
		velocidad_correr = 600
		fuerza_salto = -850
		#personajeSkin = 1
	if Input.is_action_just_pressed("ui_number_2"): #&& personajeSkin != 2:
		#get_parent().modificar_numero_cambios()
		$Sprite.texture = textura2
		velocidad_correr = 600
		fuerza_salto = -1400
		#personajeSkin = 2
	if Input.is_action_just_pressed("ui_number_3"): #&& personajeSkin != 3:
		#get_parent().modificar_numero_cambios()
		$Sprite.texture = textura3
		velocidad_correr = 800
		fuerza_salto = -850
		#personajeSkin = 3

func se_murio():
	if  tiempo_puede_morir > 1:
		muerto = true
	else:
		 muerto = false

func _physics_process(delta):
	tiempo_puede_morir += delta
	
	get_input()
	
	if salto && velocidad.y >= 0:
		gravedad = 4000
		salto = false
	
	if position.y > 300:
		posicion_inicial()
	
	if muerto == true:
		tiempo_puede_morir = 0
		posicion_inicial()
	
	velocidad.y += gravedad * delta
	velocidad = move_and_slide(velocidad, Vector2(0, -1))

func pararJugador():
	velocidad_correr = 0

func _on_Collision_Cuerpo_body_entered(body):
	if body.is_in_group("Mapa")  && muerto == false: 
		se_murio()
	

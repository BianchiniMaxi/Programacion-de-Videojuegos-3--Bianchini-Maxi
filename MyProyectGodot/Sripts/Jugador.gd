extends KinematicBody2D

export (int) var gravedad = 1300
export (int) var velocidad_correr = 400
export (int) var fuerza_salto = -600

export (StreamTexture) var textura1
export (StreamTexture) var textura2
export (StreamTexture) var textura3

var velocidad = Vector2()
var muerto = false
var personajeSkin = 1

func posicion_inicial():
	position.y = -100
	position.x = 200
	muerto = false

func get_input():
	velocidad.x = 0
	velocidad.x += velocidad_correr
	
	if Input.is_action_just_pressed("ui_jump"):
		if is_on_floor():
			velocidad.y = fuerza_salto
	
	if Input.is_action_just_pressed("ui_number_1") && personajeSkin != 1:
		get_parent().modificar_numero_cambios()
		$Sprite.texture = textura1
		velocidad_correr = 400
		fuerza_salto = -600
		personajeSkin = 1
	if Input.is_action_just_pressed("ui_number_2") && personajeSkin != 2:
		get_parent().modificar_numero_cambios()
		$Sprite.texture = textura2
		velocidad_correr = 400
		fuerza_salto = -900
		personajeSkin = 2
	if Input.is_action_just_pressed("ui_number_3") && personajeSkin != 3:
		get_parent().modificar_numero_cambios()
		$Sprite.texture = textura3
		velocidad_correr = 600
		fuerza_salto = -600
		personajeSkin = 3

func se_murio():
	muerto = true

func _physics_process(delta):
	
	get_input()
	
	if position.y > 300:
		posicion_inicial()
		get_parent().perder_vidas()
		
	if muerto == true:
		posicion_inicial()
	
	velocidad.y += gravedad * delta
	velocidad = move_and_slide(velocidad, Vector2(0, -1))

func pararJugador():
	velocidad_correr = 0

func _on_Collision_Cuerpo_body_entered(body):
	if body.is_in_group("Mapa"): 
		posicion_inicial()
		get_parent().perder_vidas()

extends KinematicBody2D

export (int) var gravedad = 1300
export (int) var velocidad_correr = 400
export (int) var fuerza_salto = -600

export (StreamTexture) var textura1
export (StreamTexture) var textura2
export (StreamTexture) var textura3

var velocidad = Vector2()
var acelerar = false
var muerto = false

func posicion_inicial():
	position.y = -100
	position.x = 200
	muerto = false

func get_input():
	velocidad.x = 0
	velocidad.x += velocidad_correr
	
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			velocidad.y = fuerza_salto
	
	if Input.is_action_pressed('ui_right') and acelerar:
		velocidad.x += 200
	if Input.is_action_pressed('ui_left'):
		velocidad.x -= 200
	
	if Input.is_action_just_pressed("ui_number_1"):
		$Sprite.texture = textura1
		acelerar = false
		fuerza_salto = -600
	if Input.is_action_just_pressed("ui_number_2"):
		$Sprite.texture = textura2
		acelerar = false
		fuerza_salto = -900
	if Input.is_action_just_pressed("ui_number_3"):
		$Sprite.texture = textura3
		acelerar = true
		fuerza_salto = -600
	
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
	

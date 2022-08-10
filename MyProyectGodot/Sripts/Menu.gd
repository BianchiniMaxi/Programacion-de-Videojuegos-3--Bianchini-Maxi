extends Control

func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/Nivel 1.tscn")

func _on_Instructions_pressed():
	$VBoxContainer.visible = false
	$Label.visible = true

func _on_MenuButton_pressed():
	$VBoxContainer.visible = true
	$Label.visible = false

func _on_QuitButton_pressed():
	get_tree().quit()



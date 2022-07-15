extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/StartButton.grab_focus()

func _on_StartButton_pressed():
	get_tree().change_scene("res://Levels/Level 1.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()


func _on_Instructions_pressed():
	$VBoxContainer.visible = false
	$Label.visible = true

func _on_Button_pressed():
	$VBoxContainer.visible = true
	$Label.visible = false

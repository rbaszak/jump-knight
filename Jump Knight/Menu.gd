extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Fade")

var settings = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ButtonExit_pressed():
	get_tree().free()

func _on_ButtonPlay_pressed():
	get_tree().change_scene("res://Game.tscn")


func _on_SettingsButton_pressed():
	if(settings):
		$CanvasLayer/SettingsWindow.hide()
		settings = false
	else:
		$CanvasLayer/SettingsWindow.popup()
		settings = true

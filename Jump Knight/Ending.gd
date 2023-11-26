extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.disabled = !Globals.plus18ending
	$EndingPlayer.play("FadeIn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ButtonMenu_pressed():
	get_tree().change_scene("res://Menu.tscn")
	queue_free()

func _on_ButtonExit_pressed():
	get_tree().free()

func _on_Button_pressed():
	$Button.disabled = true
	$SFW.visible = false
	$Idle.visible = false
	$EndingPlayer.play("NewEnding")

extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var settings = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Music.play(Globals.musicStop)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Player.position.y < $Camera2D.position.y:
		$Camera2D.position.y -= 772
	if $Player.position.y > $Camera2D.position.y+772:
		$Camera2D.position.y += 772
	if Input.is_action_just_pressed("ui_cancel"):
		if(settings):
			$Camera2D/CanvasLayer/SettingsWindow.hide()
			settings = false
		else:
			$Camera2D/CanvasLayer/SettingsWindow.popup()
			settings = true
	if Input.is_action_just_pressed("reload"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen

func _on_SettingsButton_pressed():
	if(settings):
		$Camera2D/CanvasLayer/SettingsWindow.hide()
		settings = false
	else:
		$Camera2D/CanvasLayer/SettingsWindow.popup()
		settings = true

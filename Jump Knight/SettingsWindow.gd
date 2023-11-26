extends AcceptDialog


# Declare member variables here. Examples:
# var a = 2
# var b = "text" 
# Called when the node enters the scene tree for the first time.
var fullscreen = false
var resolutions = ["Default","1920x1080","2560x1440"]
var dictionary_h = {"Default":1020,"1920x1080":1920,"2560x1440":2560}
var dictionary_v = {"Default":772,"1920x1080":1080,"2560x1440":1440}

func _ready():
	$Node2D/VBoxContainer/OptionButton.add_item(resolutions[0],0)
	$Node2D/VBoxContainer/OptionButton.add_item(resolutions[1],1)
	$Node2D/VBoxContainer/OptionButton.add_item(resolutions[2],2)
	fullscreen = bool(SettingsVars.fullscreen)
	$Node2D/Label2/FsButton.pressed = fullscreen
	#get_tree().paused = true


func _on_ExitButton_pressed():
	get_tree().free()

func _on_MenuButton_pressed():
	Globals.musicVol = $Node2D/VolumeSlider.value
	Globals.musicStop = Music.get_playback_position()
	get_tree().change_scene("res://Menu.tscn")

func _on_CheckButton_pressed():
	if(Globals.plus18ending):
		Globals.plus18ending = false
		$Node2D/CheckButton.pressed = false
	else:
		Globals.plus18ending = true
		$Node2D/CheckButton.pressed = true

func _on_SettingsWindow_confirmed():
	SettingsVars.save_settings()

func _on_OptionButton_item_selected(index):
	SettingsVars.resolution_h = dictionary_h[resolutions[index]]
	SettingsVars.resolution_v = dictionary_v[resolutions[index]]
	var res = Vector2(dictionary_h[resolutions[index]],dictionary_v[resolutions[index]])
	OS.set_window_size(res)

func _on_FsButton_pressed():
	SettingsVars.fullscreen = !SettingsVars.fullscreen
	OS.window_fullscreen = SettingsVars.fullscreen

extends Node

var settings_file = "user://settings.save"

var default_h = 1020
var default_v = 772
var resolution_h = 1020
var resolution_v = 772
export(String) var fullscreen = false

func _ready():
	load_settings()
	if bool(fullscreen):
		OS.window_fullscreen = true
	var res = Vector2(resolution_h,resolution_v)
	OS.set_window_size(res)

func save_settings():
	var config = ConfigFile.new()
	config.set_value("settings", "resolution_h", resolution_h)
	config.set_value("settings", "resolution_v", resolution_v)
	config.set_value("settings", "fullscreen", fullscreen)
	config.save(settings_file)

func load_settings():
	var config = ConfigFile.new()
	var err = config.load(settings_file)
	if err != OK:
		return
	for settings in config.get_sections():
		resolution_h = config.get_value(settings, "resolution_h")
		resolution_v = config.get_value(settings, "resolution_v")
		fullscreen = config.get_value(settings, "fullscreen")

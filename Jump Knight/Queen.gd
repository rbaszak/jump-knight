extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if(body.name=="Player"):
		$Audio.play()
		$CanvasLayer/ColorRect.visible = true
		$Player.play("Fading")


func _on_AnimationPlayer_animation_finished(anim_name):
	if(anim_name=="Fading"):
		get_tree().change_scene("res://Ending.tscn")
		Music.stop()
		get_tree().get_root().get_node("Game").queue_free()
		queue_free()

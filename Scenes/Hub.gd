extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	print(OS.get_name())
	if OS.get_name() =="Mobile":
		pass
	if OS.get_name() == "Vr":
		pass
		
	get_tree().change_scene("res://Scenes/Vr/World.tscn")


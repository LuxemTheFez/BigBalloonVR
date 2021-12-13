extends Node


func _ready():
	print(OS.get_name())
	if OS.get_name() =="Mobile":
		pass
	if ARVRServer.find_interface("OVRMobile"):
		get_tree().change_scene("res://Scenes/Vr/World.tscn")


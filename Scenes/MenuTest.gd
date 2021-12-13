extends Control



func _on_Button_pressed():
	Network.joinServer()
	get_tree().change_scene("res://Scenes/Mobile/Field.tscn")

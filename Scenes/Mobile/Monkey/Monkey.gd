extends Node2D


var vie = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_Touch_pressed():
	vie-=1
	$Label.text = str(vie)
	if(vie == 0):
		self.queue_free()

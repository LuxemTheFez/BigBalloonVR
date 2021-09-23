extends Node2D


export(Color) var color = $AnimatedSprite.get_modulate() setget changeColor


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func changeColor(value):
	color = value
	$AnimatedSprite.set_modulate(value)

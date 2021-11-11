extends Spatial

onready var ballon = load("res://Scenes/Both/Balloon2D.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	



func _process(delta):
	var ballonInstance = ballon.instance()
	add_child(ballonInstance)

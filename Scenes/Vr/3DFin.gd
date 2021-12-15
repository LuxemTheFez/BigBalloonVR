extends Spatial

onready var NODE_PLAYER = preload("res://Scenes/Vr/Player.tscn")
var player
# Called when the node enters the scene tree for the first time.
func _ready():
	player = NODE_PLAYER.instance()
	# To comment to play on editor
	add_child(player)

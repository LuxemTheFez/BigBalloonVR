extends Control

var network = NetworkedMultiplayerENet.new()
const DEFAULT_IP: String = "127.0.0.1"
const DEFAULT_PORT: int = 1770


var id: int = 0


func _ready():
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	

	
func _connected_ok():
	print("connected")
	
func _connected_fail():
	print("failed to connect")


func lancerServer():
	network.create_client(DEFAULT_IP, DEFAULT_PORT)
	get_tree().set_network_peer(network)

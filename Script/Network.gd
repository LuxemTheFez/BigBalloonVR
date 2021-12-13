extends Node

var network = NetworkedMultiplayerENet.new()
const DEFAULT_IP: String = "192.168.8.180"
const DEFAULT_PORT: int = 1770

var id: int = 0

func joinServer():
	network.create_client(DEFAULT_IP, DEFAULT_PORT)
	get_tree().set_network_peer(network)
	
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	

func _connected_ok():
	print("connected")
	
func _connected_fail():
	print("failed to connect")

func spawnBalloon(type,path):
	rpc_id(1, "spawnBalloon", type,path)


signal spawnBalloon3D(type,path)
remote func spawnBalloon3D(type,path):
	print(type)
	print(path)
	print("pouet hihinetowkr")
	emit_signal("spawnBalloon3D", type,path)

extends Node

var network = NetworkedMultiplayerENet.new()
const DEFAULT_IP: String = "192.168.1.39"
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

func spawnBalloon(type,path,idBalloon):
	rpc_id(1, "spawnBalloon", type,path,idBalloon)


signal spawnBalloon3D(type,path,idBalloon)
remote func spawnBalloon3D(type,path,idBalloon):
	emit_signal("spawnBalloon3D", type,path,idBalloon)

func sendKillBalloon(parentPath, balloonId):
	print("nom : ", balloonId)
	rpc_id(1, "receiveKillBalloon", parentPath,balloonId)

signal killBallon(parentPath,balloonId)
remote func killBalloon(parentPath,balloonId):
	print("ici : ")
	print(parentPath,balloonId)
	emit_signal("killBallon", parentPath,balloonId)
	
func popBallon(balloonId):
	pass

extends Node

var network = NetworkedMultiplayerENet.new()
const DEFAULT_IP: String = "172.20.10.8"
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

func spawnBalloon(type,path,idBalloon,offset):
	rpc_id(1, "spawnBalloon", type,path,idBalloon,offset)


signal spawnBalloon3D(type,path,idBalloon,offset)
remote func spawnBalloon3D(type,path,idBalloon,offset):
	print("path : ",path)
	emit_signal("spawnBalloon3D", type,path,idBalloon,offset)

func sendKillBalloon(parentPath, balloonId):
	rpc_id(1, "receiveKillBalloon", parentPath,balloonId)

signal killBallon(parentPath,balloonId)
remote func killBalloon(parentPath,balloonId):
	emit_signal("killBallon", parentPath,balloonId)
	
func CallPopBalloon(path,balloonId,damage):
	rpc_id(1, "remotePop", path,balloonId,damage)

signal receivePop(path,idBalloon,damage)
remote func receivePop(path,idBalloon,damage):
	emit_signal("receivePop",path,idBalloon,damage)

func remoteUpdateHp(health):
	print("envoie : ", health)
	rpc_id(1, "receiveUpdateHp",health)

signal updateHp(health)
remote func receiveUpdateHp(health):
	print("reçoit health")
	emit_signal("updateHp",health)

func finPartie():
	rpc_id(1, "remoteFinPartie")

signal sendFinPartie()
remote func sendFinPartie():
	 emit_signal("sendFinPartie")

func ajouteSinge(x,z,name):
	rpc_id(1, "sendSinge", x,z,name)

signal receiveSinge(x,z,name)
remote func receiveSinge(x,z,name):
	 emit_signal("receiveSinge",x,z,name)

func killMonkey(name):
	rpc_id(1, "sendKillMonkey", name)

signal receiveKillSinge(name)
remote func receiveKillSinge(name):
	 emit_signal("receiveKillSinge",name)

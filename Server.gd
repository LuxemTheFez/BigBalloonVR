extends Node

var network = NetworkedMultiplayerENet.new()
var port:int = 1770
var maxPlayers:int = 2
var playerStateCollection = {}


func _ready():
	network.create_server(port, maxPlayers)
	get_tree().set_network_peer(network)
	print("server lancé")
	
	
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")


func _player_connected(id):
	print("Le joueur d'id : ", id, " s'est connecté")


func _player_disconnected(id):
	print("Le joueur d'id : ", id, " s'est deconnecté")



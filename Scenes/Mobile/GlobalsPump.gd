extends Node

var typeBalloon = GlobalsBalloons.types.RED

var slowness = 2.0

var air = 0
var air_max = 100

signal changeTypeBalloons(new_type)
func changeTypeBalloons(new_type):
	typeBalloon = new_type
	emit_signal("changeTypeBalloons",new_type)

signal changeSlowness(new_slowness)
func changeSlowness(new_slowness):
	slowness = new_slowness
	emit_signal("changeSlowness",new_slowness)

signal changeAir(new_air)
func changeAir(new_air):
	air = new_air
	emit_signal("changeAir",new_air)

signal changeAirMax(new_air_max)
func changeAirMax(new_air_max):
	air_max = new_air_max
	emit_signal("changeAirMax",new_air_max)

extends Node
#class_name GlobalsBalloons

enum types {
	RED,
	BLUE,
	GREEN,
	YELLOW,
	PINK,
	BLACK,
	WHITE,
	PURPLE,
	LEAD,
	ZEBRA,
	RAINBOW,
	CERAMIC,
	MOAB,
	BFB,
	ZOMG,
	DDT,
	BAD
}

enum power_ups {
	FORTIFIED,
	CAMO,
	REGROWTH
}

var speed = 10

var stopMouse = false

onready var NODE_BALLOON2D = preload("res://Scenes/Both/Balloon2D.tscn")

func getDamage(balloon):
	var value = 0
	match balloon.type:
		types.RED:
			value = 1
		types.BLUE:
			value = 2
		types.GREEN:
			value = 3
		types.YELLOW:
			value = 4
		types.PINK:
			value = 5
		types.BLACK:
			value = 11
		types.WHITE:
			value = 11
		types.PURPLE:
			value = 11
		types.LEAD:
			value = 23
		types.ZEBRA:
			value = 23
		types.RAINBOW:
			value = 47
		types.CERAMIC:
			value = 104
		types.MOAB:
			value = 616
		types.BFB:
			value = 3164
		types.ZOMG:
			value = 16656
		types.DDT:
			value = 816
		types.BAD:
			value = 55760
	return value

func getHp(balloon):
	var value = 0
	match balloon.type:
		types.RED:
			value = 1
		types.BLUE:
			value = 1
		types.GREEN:
			value = 1
		types.YELLOW:
			value = 1
		types.PINK:
			value = 1
		types.BLACK:
			value = 1
		types.WHITE:
			value = 1
		types.PURPLE:
			value = 1
		types.LEAD:
			value = 1
		types.ZEBRA:
			value = 1
		types.RAINBOW:
			value = 1
		types.CERAMIC:
			value = 10
		types.MOAB:
			value = 200
		types.BFB:
			value = 700
		types.ZOMG:
			value = 4000
		types.DDT:
			value = 400
		types.BAD:
			value = 20000
	return value

func getSpeed(balloon):
	var value = 0
	match balloon.type:
		types.RED:
			value = 1
		types.BLUE:
			value = 1.4
		types.GREEN:
			value = 1.8
		types.YELLOW:
			value = 3.2
		types.PINK:
			value = 3.5
		types.BLACK:
			value = 1.8
		types.WHITE:
			value = 2
		types.PURPLE:
			value = 3
		types.LEAD:
			value = 1
		types.ZEBRA:
			value = 1.8
		types.RAINBOW:
			value = 1.8
		types.CERAMIC:
			value = 2.5
		types.MOAB:
			value = 1
		types.BFB:
			value = 0.25
		types.ZOMG:
			value = 0.18
		types.DDT:
			value = 2.75
		types.BAD:
			value = 0.18
	return value

func pop(balloon):
	match balloon.type:
		types.RED:
			balloon.get_parent().queue_free()
		types.BLUE:
			balloon.type = types.RED
		types.GREEN:
			balloon.type = types.BLUE
		types.YELLOW:
			balloon.type = types.GREEN
		types.PINK:
			balloon.type = types.YELLOW
		types.BLACK:
			create_balloon(balloon,types.PINK,-8)
			create_balloon(balloon,types.PINK,8)
		types.WHITE:
			create_balloon(balloon,types.PINK,-8)
			create_balloon(balloon,types.PINK,8)
			balloon.get_parent().queue_free()
		types.PURPLE:
			create_balloon(balloon,types.PINK,-8)
			create_balloon(balloon,types.PINK,8)
			balloon.get_parent().queue_free()
		types.LEAD:
			create_balloon(balloon,types.BLACK,-8)
			create_balloon(balloon,types.BLACK,8)
			balloon.get_parent().queue_free()
		types.ZEBRA:
			create_balloon(balloon,types.WHITE,-8)
			create_balloon(balloon,types.BLACK,8)
			balloon.get_parent().queue_free()
		types.RAINBOW:
			create_balloon(balloon,types.ZEBRA,-8)
			create_balloon(balloon,types.ZEBRA,8)
			balloon.get_parent().queue_free()
		types.CERAMIC:
			create_balloon(balloon,types.RAINBOW,-8)
			create_balloon(balloon,types.RAINBOW,8)
			balloon.get_parent().queue_free()
		types.MOAB:
			create_balloon(balloon,types.CERAMIC,-24)
			create_balloon(balloon,types.CERAMIC,-8)
			create_balloon(balloon,types.CERAMIC,8)
			create_balloon(balloon,types.CERAMIC,24)
			balloon.get_parent().queue_free()
		types.BFB:
			create_balloon(balloon,types.MOAB,-24)
			create_balloon(balloon,types.MOAB,-8)
			create_balloon(balloon,types.MOAB,8)
			create_balloon(balloon,types.MOAB,24)
			balloon.get_parent().queue_free()
		types.ZOMG:
			create_balloon(balloon,types.BFB,-24)
			create_balloon(balloon,types.BFB,-8)
			create_balloon(balloon,types.BFB,8)
			create_balloon(balloon,types.BFB,24)
			balloon.get_parent().queue_free()
		types.DDT:
			create_balloon(balloon,types.CERAMIC,-24)
			create_balloon(balloon,types.CERAMIC,-8)
			create_balloon(balloon,types.CERAMIC,8)
			create_balloon(balloon,types.CERAMIC,24)
			balloon.get_parent().queue_free()
		types.BAD:
			create_balloon(balloon,types.DDT,-32)
			create_balloon(balloon,types.DDT,-16)
			create_balloon(balloon,types.DDT,0)
			create_balloon(balloon,types.ZOMG,16)
			create_balloon(balloon,types.ZOMG,32)
			balloon.get_parent().queue_free()

func create_balloon(father_balloon,type,offset):
			var new_balloon = NODE_BALLOON2D.instance()
			new_balloon.type = type
			var new_path = father_balloon.get_parent().duplicate()
			if(new_path.get_child_count() > 0):
				new_path.get_child(0).queue_free()
			new_path.set_offset(new_path.get_offset()+offset)
			new_path.add_child(new_balloon)
			father_balloon.get_parent().get_parent().add_child(new_path)

func getColor(balloon):
	var value = Color(1,1,1,1)
	match balloon.type:
		types.RED:
			value = Color(0.93,0.07,00.7,1)
		types.BLUE:
			value = Color(0.13,0.56,0.87,1)
		types.GREEN:
			value = Color(0.45,0.65,0.04,1)
		types.YELLOW:
			value = Color(1,0.84,0.05,1)
		types.PINK:
			value = Color(0.94,0.28,0.35,1)
		types.BLACK:
			value = Color(0.06,0.06,0.06,1)
		types.WHITE:
			value = Color(0.83,0.83,0.83,1)
		types.PURPLE:
			value = Color(0.55,0.1,0.875,1)
		types.LEAD:
			value = Color(0.5,0.5,0.5,1)
		types.ZEBRA:
			value = Color(0.83,0.83,0.83,0.7)
		types.RAINBOW:
			value = Color(1,1,1,1)
		types.CERAMIC:
			value = Color(0.73,0.416,0.118,1)
		types.MOAB:
			value = Color(0,0.55,0.85,1)
		types.BFB:
			value = Color(0.73,0,0,1)
		types.ZOMG:
			value = Color(0.3,0.87,0,1)
		types.DDT:
			value = Color(0.21,0.23,0.20,1)
		types.BAD:
			value = Color(0.6,0.15,0.65,1)
	return value
	
func getSprite(balloon):
	var value = "res://Assets/balloon.png"
	if(isZeppelin(balloon)):
		value = "res://Assets/zeppelin.png"
	return value

func isZeppelin(balloon):
	var t = balloon.type
	var zeppelins = [types.MOAB,types.BFB,types.ZOMG,types.DDT,types.BAD]
	return t in zeppelins

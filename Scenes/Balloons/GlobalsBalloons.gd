extends Node
class_name GlobalsBalloon

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

var speed = 30

onready var NODE_BALLOON2D = preload("res://Scenes/Both/Balloon2D.tscn")

func get_damage(balloon):
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
			var new_balloon1 = NODE_BALLOON2D.instance()
			var new_balloon2 = NODE_BALLOON2D.instance()
			new_balloon1.type = types.PINK
			new_balloon2.type = types.PINK
			var new_path1 = balloon.get_parent().duplicate()
			var new_path2 = balloon.get_parent().duplicate()
			new_path1.set_offset(new_path1.get_offset()-8)
			new_path2.set_offset(new_path2.get_offset()+8)
			new_path1.add_child(new_balloon1)
			new_path2.add_child(new_balloon2)
			balloon.get_parent().get_parent().add_child(new_path1)
			balloon.get_parent().get_parent().add_child(new_path2)
			balloon.get_parent().queue_free()
		types.WHITE:
			var new_balloon1 = NODE_BALLOON2D.instance()
			var new_balloon2 = NODE_BALLOON2D.instance()
			new_balloon1.type = types.PINK
			new_balloon2.type = types.PINK
			var new_path1 = balloon.get_parent().duplicate()
			var new_path2 = balloon.get_parent().duplicate()
			new_path1.set_offset(new_path1.get_offset()-8)
			new_path2.set_offset(new_path2.get_offset()+8)
			new_path1.add_child(new_balloon1)
			new_path2.add_child(new_balloon2)
			balloon.get_parent().get_parent().add_child(new_path1)
			balloon.get_parent().get_parent().add_child(new_path2)
			balloon.get_parent().queue_free()
		types.PURPLE:
			var new_balloon1 = NODE_BALLOON2D.instance()
			var new_balloon2 = NODE_BALLOON2D.instance()
			new_balloon1.type = types.PINK
			new_balloon2.type = types.PINK
			var new_path1 = balloon.get_parent().duplicate()
			var new_path2 = balloon.get_parent().duplicate()
			new_path1.set_offset(new_path1.get_offset()-8)
			new_path2.set_offset(new_path2.get_offset()+8)
			new_path1.add_child(new_balloon1)
			new_path2.add_child(new_balloon2)
			balloon.get_parent().get_parent().add_child(new_path1)
			balloon.get_parent().get_parent().add_child(new_path2)
			balloon.get_parent().queue_free()
		types.LEAD:
			var new_balloon1 = NODE_BALLOON2D.instance()
			var new_balloon2 = NODE_BALLOON2D.instance()
			new_balloon1.type = types.BLACK
			new_balloon2.type = types.BLACK
			var new_path1 = balloon.get_parent().duplicate()
			var new_path2 = balloon.get_parent().duplicate()
			new_path1.set_offset(new_path1.get_offset()-8)
			new_path2.set_offset(new_path2.get_offset()+8)
			new_path1.add_child(new_balloon1)
			new_path2.add_child(new_balloon2)
			balloon.get_parent().get_parent().add_child(new_path1)
			balloon.get_parent().get_parent().add_child(new_path2)
			balloon.get_parent().queue_free()
		types.ZEBRA:
			var new_balloon1 = NODE_BALLOON2D.instance()
			var new_balloon2 = NODE_BALLOON2D.instance()
			new_balloon1.type = types.BLACK
			new_balloon2.type = types.WHITE
			var new_path1 = balloon.get_parent().duplicate()
			var new_path2 = balloon.get_parent().duplicate()
			new_path1.set_offset(new_path1.get_offset()-8)
			new_path2.set_offset(new_path2.get_offset()+8)
			new_path1.add_child(new_balloon1)
			new_path2.add_child(new_balloon2)
			balloon.get_parent().get_parent().add_child(new_path1)
			balloon.get_parent().get_parent().add_child(new_path2)
			balloon.get_parent().queue_free()
		types.RAINBOW:
			var new_balloon1 = NODE_BALLOON2D.instance()
			var new_balloon2 = NODE_BALLOON2D.instance()
			new_balloon1.type = types.ZEBRA
			new_balloon2.type = types.ZEBRA
			var new_path1 = balloon.get_parent().duplicate()
			var new_path2 = balloon.get_parent().duplicate()
			new_path1.set_offset(new_path1.get_offset()-8)
			new_path2.set_offset(new_path2.get_offset()+8)
			new_path1.add_child(new_balloon1)
			new_path2.add_child(new_balloon2)
			balloon.get_parent().get_parent().add_child(new_path1)
			balloon.get_parent().get_parent().add_child(new_path2)
			balloon.get_parent().queue_free()
		types.CERAMIC:
			var new_balloon1 = NODE_BALLOON2D.instance()
			var new_balloon2 = NODE_BALLOON2D.instance()
			new_balloon1.type = types.RAINBOW
			new_balloon2.type = types.RAINBOW
			var new_path1 = balloon.get_parent().duplicate()
			var new_path2 = balloon.get_parent().duplicate()
			new_path1.set_offset(new_path1.get_offset()-8)
			new_path2.set_offset(new_path2.get_offset()+8)
			new_path1.add_child(new_balloon1)
			new_path2.add_child(new_balloon2)
			balloon.get_parent().get_parent().add_child(new_path1)
			balloon.get_parent().get_parent().add_child(new_path2)
			balloon.get_parent().queue_free()
		types.MOAB:
			var new_balloon1 = NODE_BALLOON2D.instance()
			var new_balloon2 = NODE_BALLOON2D.instance()
			var new_balloon3 = NODE_BALLOON2D.instance()
			var new_balloon4 = NODE_BALLOON2D.instance()
			new_balloon1.type = types.CERAMIC
			new_balloon2.type = types.CERAMIC
			new_balloon3.type = types.CERAMIC
			new_balloon4.type = types.CERAMIC
			var new_path1 = balloon.get_parent().duplicate()
			var new_path2 = balloon.get_parent().duplicate()
			var new_path3 = balloon.get_parent().duplicate()
			var new_path4 = balloon.get_parent().duplicate()
			new_path1.set_offset(new_path1.get_offset()-24)
			new_path2.set_offset(new_path2.get_offset()-8)
			new_path3.set_offset(new_path3.get_offset()+8)
			new_path4.set_offset(new_path4.get_offset()+24)
			new_path1.add_child(new_balloon1)
			new_path2.add_child(new_balloon2)
			new_path3.add_child(new_balloon3)
			new_path4.add_child(new_balloon4)
			balloon.get_parent().get_parent().add_child(new_path1)
			balloon.get_parent().get_parent().add_child(new_path2)
			balloon.get_parent().get_parent().add_child(new_path3)
			balloon.get_parent().get_parent().add_child(new_path4)
			balloon.get_parent().queue_free()
		types.BFB:
			var new_balloon1 = NODE_BALLOON2D.instance()
			var new_balloon2 = NODE_BALLOON2D.instance()
			var new_balloon3 = NODE_BALLOON2D.instance()
			var new_balloon4 = NODE_BALLOON2D.instance()
			new_balloon1.type = types.MOAB
			new_balloon2.type = types.MOAB
			new_balloon3.type = types.MOAB
			new_balloon4.type = types.MOAB
			var new_path1 = balloon.get_parent().duplicate()
			var new_path2 = balloon.get_parent().duplicate()
			var new_path3 = balloon.get_parent().duplicate()
			var new_path4 = balloon.get_parent().duplicate()
			new_path1.set_offset(new_path1.get_offset()-24)
			new_path2.set_offset(new_path2.get_offset()-8)
			new_path3.set_offset(new_path3.get_offset()+8)
			new_path4.set_offset(new_path4.get_offset()+24)
			new_path1.add_child(new_balloon1)
			new_path2.add_child(new_balloon2)
			new_path3.add_child(new_balloon3)
			new_path4.add_child(new_balloon4)
			balloon.get_parent().get_parent().add_child(new_path1)
			balloon.get_parent().get_parent().add_child(new_path2)
			balloon.get_parent().get_parent().add_child(new_path3)
			balloon.get_parent().get_parent().add_child(new_path4)
			balloon.get_parent().queue_free()
		types.ZOMG:
			var new_balloon1 = NODE_BALLOON2D.instance()
			var new_balloon2 = NODE_BALLOON2D.instance()
			var new_balloon3 = NODE_BALLOON2D.instance()
			var new_balloon4 = NODE_BALLOON2D.instance()
			new_balloon1.type = types.BFB
			new_balloon2.type = types.BFB
			new_balloon3.type = types.BFB
			new_balloon4.type = types.BFB
			var new_path1 = balloon.get_parent().duplicate()
			var new_path2 = balloon.get_parent().duplicate()
			var new_path3 = balloon.get_parent().duplicate()
			var new_path4 = balloon.get_parent().duplicate()
			new_path1.set_offset(new_path1.get_offset()-24)
			new_path2.set_offset(new_path2.get_offset()-8)
			new_path3.set_offset(new_path3.get_offset()+8)
			new_path4.set_offset(new_path4.get_offset()+24)
			new_path1.add_child(new_balloon1)
			new_path2.add_child(new_balloon2)
			new_path3.add_child(new_balloon3)
			new_path4.add_child(new_balloon4)
			balloon.get_parent().get_parent().add_child(new_path1)
			balloon.get_parent().get_parent().add_child(new_path2)
			balloon.get_parent().get_parent().add_child(new_path3)
			balloon.get_parent().get_parent().add_child(new_path4)
			balloon.get_parent().queue_free()
		types.DDT:
			var new_balloon1 = NODE_BALLOON2D.instance()
			var new_balloon2 = NODE_BALLOON2D.instance()
			var new_balloon3 = NODE_BALLOON2D.instance()
			var new_balloon4 = NODE_BALLOON2D.instance()
			new_balloon1.type = types.CERAMIC
			new_balloon2.type = types.CERAMIC
			new_balloon3.type = types.CERAMIC
			new_balloon4.type = types.CERAMIC
			var new_path1 = balloon.get_parent().duplicate()
			var new_path2 = balloon.get_parent().duplicate()
			var new_path3 = balloon.get_parent().duplicate()
			var new_path4 = balloon.get_parent().duplicate()
			new_path1.set_offset(new_path1.get_offset()-24)
			new_path2.set_offset(new_path2.get_offset()-8)
			new_path3.set_offset(new_path3.get_offset()+8)
			new_path4.set_offset(new_path4.get_offset()+24)
			new_path1.add_child(new_balloon1)
			new_path2.add_child(new_balloon2)
			new_path3.add_child(new_balloon3)
			new_path4.add_child(new_balloon4)
			balloon.get_parent().get_parent().add_child(new_path1)
			balloon.get_parent().get_parent().add_child(new_path2)
			balloon.get_parent().get_parent().add_child(new_path3)
			balloon.get_parent().get_parent().add_child(new_path4)
			balloon.get_parent().queue_free()
		types.BAD:
			var new_balloon1 = NODE_BALLOON2D.instance()
			var new_balloon2 = NODE_BALLOON2D.instance()
			var new_balloon3 = NODE_BALLOON2D.instance()
			var new_balloon4 = NODE_BALLOON2D.instance()
			var new_balloon5 = NODE_BALLOON2D.instance()
			new_balloon1.type = types.CERAMIC
			new_balloon2.type = types.CERAMIC
			new_balloon3.type = types.CERAMIC
			new_balloon4.type = types.CERAMIC
			new_balloon5.type = types.CERAMIC
			var new_path1 = balloon.get_parent().duplicate()
			var new_path2 = balloon.get_parent().duplicate()
			var new_path3 = balloon.get_parent().duplicate()
			var new_path4 = balloon.get_parent().duplicate()
			var new_path5 = balloon.get_parent().duplicate()
			new_path1.set_offset(new_path1.get_offset()-32)
			new_path2.set_offset(new_path2.get_offset()-16)
			new_path3.set_offset(new_path3.get_offset())
			new_path4.set_offset(new_path4.get_offset()+16)
			new_path4.set_offset(new_path5.get_offset()+32)
			new_path1.add_child(new_balloon1)
			new_path2.add_child(new_balloon2)
			new_path3.add_child(new_balloon3)
			new_path4.add_child(new_balloon4)
			new_path5.add_child(new_balloon5)
			balloon.get_parent().get_parent().add_child(new_path1)
			balloon.get_parent().get_parent().add_child(new_path2)
			balloon.get_parent().get_parent().add_child(new_path3)
			balloon.get_parent().get_parent().add_child(new_path4)
			balloon.get_parent().get_parent().add_child(new_path5)
			balloon.get_parent().queue_free()

# TODO GET COULEUR
# TODO GET SPRITE

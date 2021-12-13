extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var anim = $AnimationPlayer.get_animation("walkcycle_1")
	anim.set_loop(true)
	$AnimationPlayer.set_speed_scale(0.5)
	$AnimationPlayer.play("walkcycle_1")

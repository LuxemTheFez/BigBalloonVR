extends Spatial

var can_shoot : bool = true
var balloonsInRange : Array = []

onready var NODE_BULLET = preload("res://Scenes/Vr/Monkey/Bullet.tscn")

func _ready():
	pass

func _process(delta):
	tirer()
	if(balloonsInRange.size()>0):
		look_at(balloonsInRange[0].transform.origin,Vector3.FORWARD)

func tirer():
	if(can_shoot and balloonsInRange.size()>0):
		can_shoot = false
		$AnimationPlayer.play("jump")
		var bullet = NODE_BULLET.instance()
		bullet.target = balloonsInRange[0]
		bullet.transform.origin = $BulletSpawn.transform.origin
		add_child(bullet)

func _on_Area_area_entered(area : Area):
	var parent = area.get_parent()
	if(parent.name == "Balloon3D"):
		if(not(parent in balloonsInRange)):
			balloonsInRange.append(parent)

func _on_Area_area_exited(area):
	var parent = area.get_parent()
	if(parent.name == "Balloon3D"):
		if(parent in balloonsInRange):
			balloonsInRange.erase(parent)

func _on_AnimationPlayer_animation_finished(anim_name):
	if(anim_name == "jump"):
		can_shoot=true

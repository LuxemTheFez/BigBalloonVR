extends Spatial

var can_shoot : bool = true
var balloonsInRange : Array = []

onready var NODE_BULLET = preload("res://Scenes/Vr/Monkey/Bullet.tscn")

func _ready():
	pass

func _process(delta):
	tirer()
	if(balloonsInRange.size()>0):
		var wr = weakref(balloonsInRange[0])
		if(wr.get_ref()):
			#look_at(balloonsInRange[0].global_transform.origin,Vector3.UP)
			var targetToLook = balloonsInRange[0].global_transform.origin
			var dir = balloonsInRange[0].global_transform.origin - self.global_transform.origin
			targetToLook.y = 0.0
			targetToLook.x -= 2*dir.x
			targetToLook.z -= 2*dir.z
			look_at(targetToLook, Vector3.UP)
		else:
			balloonsInRange.remove(0)

func tirer():
	if(can_shoot and balloonsInRange.size()>0):
		can_shoot = false
		var target = balloonsInRange[0]
		$AnimationPlayer.play("jump")
		yield(get_tree().create_timer(0.30), "timeout")
		var bullet = NODE_BULLET.instance()
		bullet.target = target
		bullet.global_transform.origin = $BulletSpawn.global_transform.origin
		get_parent().add_child(bullet)

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

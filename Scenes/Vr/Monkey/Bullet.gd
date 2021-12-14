extends KinematicBody

var target = null
var t = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if(target!=null):
		self.transform.origin = lerp(self.transform.origin,target.transform.origin,t)
		t+=delta

func _on_Area_area_entered(area):
	var parent = area.get_parent()
	if(parent.name == "Balloon3D"):
		self.queue_free()

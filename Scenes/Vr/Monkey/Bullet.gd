extends Spatial

var target = null
var t = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	var wr = weakref(target)
	if(target!=null and wr.get_ref()):
		if(t>1.0):
			t = 1.0
		self.global_transform.origin = lerp(self.global_transform.origin,target.global_transform.origin,t)
		t+=delta
	elif(!wr.get_ref()):
		self.queue_free()

func _on_Area_area_entered(area):
	var parent = area.get_parent()
	if(parent.name == "Balloon3D"):
		self.queue_free()

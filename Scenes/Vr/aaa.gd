extends ARVRController

var controller_velocity = Vector3(0,0,0)
var prior_controller_position = Vector3(0,0,0)
var prior_controller_velocities = []

const max_speed = 5.0
const min_speed = 1.0

var armswinger_button

var camera

var camera_transform

var armswinger_speeds = []

var velocity = Vector3(0.0, 0.0, 0.0)

enum Buttons {
	VR_BUTTON_BY = 1,
	VR_GRIP = 2,
	VR_BUTTON_3 = 3,
	VR_BUTTON_4 = 4,
	VR_BUTTON_5 = 5,
	VR_BUTTON_6 = 6,
	VR_BUTTON_AX = 7,
	VR_BUTTON_8 = 8,
	VR_BUTTON_9 = 9,
	VR_BUTTON_10 = 10,
	VR_BUTTON_11 = 11,
	VR_BUTTON_12 = 12,
	VR_BUTTON_13 = 13,
	VR_PAD = 14,
	VR_TRIGGER = 15
}


func _ready():
	
	camera = get_node("../ARVRCamera")
	
	camera_transform = camera.global_transform
	
	connect("button_pressed", self, "button_pressed")
	connect("button_release", self, "button_released")


func _physics_process(delta):
	if get_is_active() == true:
		_physics_process_update_controller_velocity(delta)

func _physics_process_update_controller_velocity(delta):
	controller_velocity = Vector3(0,0,0)

	if prior_controller_velocities.size() > 0:
		for vel in prior_controller_velocities:
			controller_velocity += vel

		controller_velocity = controller_velocity / prior_controller_velocities.size()

	var relative_controller_position = (global_transform.origin - prior_controller_position)

	controller_velocity += relative_controller_position

	prior_controller_velocities.append(relative_controller_position)

	prior_controller_position = global_transform.origin

	controller_velocity /= delta;

	if prior_controller_velocities.size() > 30:
		prior_controller_velocities.remove(0)


		if is_button_pressed(armswinger_button):
			#Get the current local controller speed
			var current_controller_speed =  prior_controller_velocities.length()
			
			#add controller speed to the list of average speeds
			armswinger_speeds.append(current_controller_speed)
			
			#if array speed is larger than 1second worth of data, remove the first one
			#TODO: make it based on 1 second instead of just the amount of frames
			if armswinger_speeds.size() > 120:
				armswinger_speeds.remove(0)
			#add all speeds together
			var total_speed = 0
			for i in armswinger_speeds:
				total_speed += i
			#get average speed
			var average_controller_speed = total_speed/armswinger_speeds.size()
			
			#apply the velocity based on either headset direction or controller direction
			#Direction based on headset orientation

			var dir_forward = camera_transform.basis.z
			dir_forward.y = 0.0	
			velocity = (-dir_forward).normalized() * average_controller_speed * delta * max_speed * ARVRServer.world_scale
			
			#Check if the speed is lower than the minimum velocity, if it is, apply the minimum velocity instead
			var min_velocity = (-dir_forward).normalized() * delta * min_speed * ARVRServer.world_scale
			if(min_velocity.length() > velocity.length()):
				velocity = min_velocity

		#clear the armswinger speeds array otherwise the velocity will be remembered
		elif !is_button_pressed(armswinger_button):
			armswinger_speeds.clear()
			
		# apply move and slide to our kinematic body
#		velocity = .move_and_slide(velocity, Vector3(0.0, 1.0, 0.0))
			
		# now use our new position to move our origin point
#		var movement = (player_controller.kinematicbody.global_transform.origin - curr_transform.origin)
#		player_controller.global_transform.origin += movement

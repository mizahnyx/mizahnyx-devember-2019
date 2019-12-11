extends Node

class_name ThirdPersonController

var rigid_body:RigidBody
var ray_cast:RayCast
var on_ground:bool = false

export var active:bool
export var ray_cast_path:String

const MOVEMENT_SPEED = 50.0
const JUMP_IMPULSE = Vector3(0, 10, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	rigid_body = self.get_parent() as RigidBody
	ray_cast = self.get_node(ray_cast_path) as RayCast

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _input(event):
	if event.is_action('jump') && on_ground:
		rigid_body.apply_central_impulse(
			rigid_body.transform.basis.xform(JUMP_IMPULSE))


func _process(delta):
	var label = $'/root/Spatial/DebugLabel' as Label
	label.text = String(delta) + ' ' + String(on_ground)


# Oh, so its similar to Unity's "FixedUpdate"
func _physics_process(delta):
	if active:
		ray_cast
		on_ground = ray_cast.is_colliding()
		
		var input = Vector3(
			Input.get_action_strength("move_left") - Input.get_action_strength("move_right"),
			0,
			Input.get_action_strength("move_forward") - Input.get_action_strength("move_back"))
			
		var motion = input.normalized() * delta * MOVEMENT_SPEED
		
		rigid_body.apply_central_impulse(
			rigid_body.transform.basis.xform(motion))
			
		
		# [ ] Aim, with the mouse or the right analog joystick in the gamepad
		# [ ] Define jump / thruster dynamics.
		# [ ] Make the align with planet center not instantaneous.
		
		# That's for today. A little late.
		# Raycast for ground detection.
		# So we can't abuse jump impulse to travel across planets anymore.
		# So we need to define thruster dynamics
		# [ ] Keep pressing JUMP to activate thruster
		# [ ] Thruster consumes boost

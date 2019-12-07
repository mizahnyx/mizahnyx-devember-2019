extends Node

class_name ThirdPersonController

var rigid_body:RigidBody

export var active:bool

# Called when the node enters the scene tree for the first time.
func _ready():
	rigid_body = self.get_parent() as RigidBody


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active:
		var input = Vector3(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			0,
			Input.get_action_strength("move_forward") - Input.get_action_strength("move_back"))
	
		var motion = input.normalized() * delta * 2.0
		
		rigid_body.apply_central_impulse(
			rigid_body.transform.xform(motion))

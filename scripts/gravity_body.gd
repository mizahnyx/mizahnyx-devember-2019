extends Node

class_name GravityBody

var rigid_body:RigidBody

onready var gravity_attractor:GravityAttractor = $'/root/Spatial/Planet02/GravityAttractor'


func _ready():
	rigid_body = self.get_parent() as RigidBody
	rigid_body.mode = RigidBody.MODE_CHARACTER


func _process(delta):
	var spatial:Spatial = gravity_attractor.get_parent() as Spatial
	var gravity_direction = (rigid_body.transform.origin - spatial.transform.origin)
	
	var old_basis = rigid_body.transform.basis
	var new_basis = Basis()
	
	# I'm stuck again! bye bye...
	
	new_basis.x = (gravity_direction).cross(old_basis.z)
	new_basis.y = gravity_direction
	new_basis.z = old_basis.x.cross(gravity_direction)
	
	rigid_body.transform.basis = new_basis.orthonormalized()
	
	rigid_body.add_central_force(gravity_direction * -9.81)

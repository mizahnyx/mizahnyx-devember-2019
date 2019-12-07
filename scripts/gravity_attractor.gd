extends Node

class_name GravityAttractor

var gravity = 9.81

# Called when the node enters the scene tree for the first time.
func attract(gravity_body, delta):
	var parent = self.get_parent()
	var gravity_body_parent = gravity_body.get_parent()
	
	var local_up = gravity_body_parent.transform.basis.y
	var gravity_up = (parent.transform.origin - gravity_body_parent.transform.origin).normalized()

	gravity_body_parent.add_central_force(gravity_up * gravity)
	
	var rotation_axis = local_up.cross(gravity_up).normalized()
#
	var quat = Quat(
		rotation_axis.x,
		rotation_axis.y,
		rotation_axis.z,
		1 + local_up.dot(gravity_up)).normalized()
		
	gravity_body_parent.transform.basis = Basis(
		quat.xform(gravity_body_parent.transform.basis.x),
		quat.xform(gravity_body_parent.transform.basis.y),
		quat.xform(gravity_body_parent.transform.basis.z)).orthonormalized()
#
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(_delta):
	pass

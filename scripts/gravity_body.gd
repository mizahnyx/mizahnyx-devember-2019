extends RigidBody

class_name GravityBody

onready var gravity_controller = $'/root/Spatial'

export var maximum_velocity:float = 10.0

func _integrate_forces(state:PhysicsDirectBodyState):
	var nearest_attractor = gravity_controller.nearest_attractor(state.transform.origin)
	
	if nearest_attractor != null:
		var spatial:Spatial = nearest_attractor.get_parent() as Spatial
		var gravity_direction = (self.transform.origin - spatial.transform.origin)
		var old_basis = state.transform.basis
		var new_basis = Basis()

		new_basis.x = (gravity_direction).cross(old_basis.z)
		new_basis.y = gravity_direction
		new_basis.z = old_basis.x.cross(gravity_direction)
		
		state.transform.basis = new_basis.orthonormalized()
		
	if state.linear_velocity.length_squared() > (maximum_velocity * maximum_velocity):
		state.linear_velocity = state.linear_velocity.normalized() * maximum_velocity


func _ready():
	self.mode = RigidBody.MODE_CHARACTER

	
func _physics_process(_delta):
	var nearest_attractor = gravity_controller.nearest_attractor(self.transform.origin)
	
	if nearest_attractor != null:
		var spatial:Spatial = nearest_attractor.get_parent() as Spatial
		var gravity_direction = (self.transform.origin - spatial.transform.origin)
		
		
		add_central_force(gravity_direction.normalized() * -9.81)
	
# [X] Framerate is unstable
# [X] We can optimize, not changing the basis until the angle between gravity_direction and
#     our current basis Z reaches certain threshold
# [X] Wait! gravity direction is not normalized, but applied as is. That is bad
# [X] So, the commented out part seems to be the culprit of the slowdown
# [X] Homework for tomorrow. Find a better way to orient Y axis towards gravity direction.
# A little less than an hour, but enough for today.

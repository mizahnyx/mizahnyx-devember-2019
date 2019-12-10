extends Node

class_name GravityController

var attractors:Array = []


func register_attractor(attractor):
	self.attractors.append(attractor)
	

func unregister_attractor(attractor):
	self.attractors.erase(attractor)


func nearest_attractor(position:Vector3):
	var candidates = []
	var distances_squared = []
	
	for attractor in self.attractors:
		var attractor_parent = (attractor as Node).get_parent() as Spatial
		var distance_squared = position.distance_squared_to(attractor_parent.transform.origin)
		if distance_squared < (attractor.radius * attractor.radius):
			candidates.append(attractor)
			distances_squared.append(distance_squared)
			
	var result = null
	
	if len(candidates) == 0:
		return result
		
	var min_distance = distances_squared[0]
	result = candidates[0]
	
	for i in range(len(candidates)):
		if distances_squared[i] < min_distance:
			result = candidates[i]
			min_distance = distances_squared[i]
			
	return result

func _ready():
	pass

extends Area2D
class_name Interactor

# TODO add a cooldown

@export var accepting_input := true

func _input(event: InputEvent) -> void:
	if accepting_input && Input.is_action_just_pressed("interact"):
		print("me when I attempt to interact:")
		var areas = get_interactables(
			get_overlapping_areas()
		)
		if not areas: return
		var closest_area : Area2D = get_closest_interactable(areas)
		(closest_area as Interactable).interact()

func get_closest_interactable(areas):
	var dists : Array[float] = []
	for i in range(0, len(areas)):
		dists.append(global_position.distance_to(areas[i].global_position))
		var min_dist = 1000000
		for dist in dists:
			min_dist = min(dist, min_dist)
		return areas[dists.find(min_dist)]	# sorry


func get_interactables(areas):
	var interactables := []
	for area in areas:
		if area is Interactable:
			interactables.append(area)
	
	return interactables

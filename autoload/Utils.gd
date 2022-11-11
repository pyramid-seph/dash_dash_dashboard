extends Node


func rand_item(arr: Array):
	if arr == null or arr.is_empty():
		return null
	return arr[randi() % arr.size()]


func create_instance(scene: PackedScene, parent: Node, position: Vector2) -> Node:
	var new_instance = scene.instantiate()
	new_instance.position = position
	parent.add_child(new_instance)
	return new_instance

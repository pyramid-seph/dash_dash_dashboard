extends Node

const ALPHABET = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L",
 "M", "N", "Ñ", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]


func rand_item(arr: Array):
	if arr == null or arr.is_empty():
		return null
	return arr[randi() % arr.size()]


func create_instance(scene: PackedScene, parent: Node, position: Vector2) -> Node:
	var new_instance = scene.instantiate()
	new_instance.position = position
	parent.add_child(new_instance)
	return new_instance


func rand_alphabet_string(length: int = 10) -> String:
	var new_string: String = ""
	if length <= 0:
		return new_string
	for _i in length:
		new_string = new_string + rand_item(ALPHABET)
	return new_string

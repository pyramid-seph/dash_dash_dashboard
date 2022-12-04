class_name PersonRandomizer
extends Node

const MIN_AGE: int = 18
const MAX_AGE: int = 100

@export var person_data_source: Resource


func create_random_person() -> PersonDescriptor:
	var person = PersonDescriptor.new()
	person.name = _create_full_name()
	person.address = Utils.rand_item(person_data_source.addresses)
	person.age = randi_range(MIN_AGE, MAX_AGE)
	person.eye_color = Utils.rand_item(person_data_source.eye_colors)
	person.curp = Utils.rand_alphabet_string()
	person.eye_type = randi() % person_data_source.eye_types.size()
	person.head_type = randi() % person_data_source.head_types.size()
	person.mouth_type = randi() % person_data_source.mouth_types.size()
	person.nose_type = randi() % person_data_source.nose_types.size()
	return person


func _create_name(names_source) -> String:
	var first_name: String = Utils.rand_item(names_source)
	var middle_name
	for _i in 10:
		middle_name = Utils.rand_item(names_source)
		if middle_name != first_name: break
	return " ".join([first_name, middle_name])


func _create_full_name() -> String:
	var person_name: String
	if (randi() % 2 == 0):
		person_name = _create_name(person_data_source.male_names)
	else:
		person_name = _create_name(person_data_source.female_names)
	var last_name: String = "%s %s" % [
		Utils.rand_item(person_data_source.last_names),
		Utils.rand_item(person_data_source.last_names),
	]
	return " ".join([person_name, last_name])

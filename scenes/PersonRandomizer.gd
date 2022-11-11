class_name PersonRandomizer
extends Node

const MIN_AGE = 18
const MAX_AGE = 100

@export var body_types: Array[String] = []
@export var head_types: Array[String] = []
@export var eye_types: Array[String] = []
@export var eye_colors: Array[Color] = [Color.GREEN, Color.RED, Color.BLUE, Color.BLACK, Color.BROWN]
@export var nose_types: Array[String] = []
@export var mouth_types: Array[String] = []
@export var male_names : Array[String] = ["Juan", "Tito", "Mario"]
@export var female_names : Array[String] = ["Giselle", "Té", "Fabiola"]
@export var last_names : Array[String] = ["Morales", "Pintor", "Ceh", "Pech", "Pérez"]
@export var addresses : Array[String] = ["Avenida Siempre Viva", "Avenida Siempre Muerta", "Elm Street"]


func create_random_person() -> PersonDescriptor:
	var person = PersonDescriptor.new()
	person.name = _create_full_name()
	person.address = Utils.rand_item(addresses)
	person.age = randi_range(MIN_AGE, MAX_AGE)
	person.eye_color = Utils.rand_item(eye_colors)
	person.curp = Utils.rand_alphanumeric_string()
	print(str(person))
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
		person_name = _create_name(male_names)
	else:
		person_name = _create_name(female_names)
	var last_name: String = "%s %s" % [Utils.rand_item(last_names), Utils.rand_item(last_names)]
	return " ".join([person_name, last_name])

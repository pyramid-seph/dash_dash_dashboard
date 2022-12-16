extends HBoxContainer

@export var title: String

@onready var full_name := $VBoxContainer/FullName as Label
@onready var age := $VBoxContainer/Age as Label
@onready var address := $VBoxContainer/Address as Label
@onready var curp := $VBoxContainer/Curp as Label
@onready var person_image := $PersonImage as PersonImage


func populate(person_data: PersonDataSource, person_descriptor: PersonDescriptor) -> void:
	if person_descriptor == null or person_data == null:
		full_name.text = ""
		age.text = ""
		address.text = ""
		curp.text = ""
		person_image.clear()
	else:
		full_name.text = person_descriptor.name
		age.text = str(person_descriptor.age)
		address.text = person_descriptor.address
		curp.text = person_descriptor.curp
		person_image.generate(person_data, person_descriptor)


func clear() -> void:
	populate(null, null)

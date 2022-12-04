extends HBoxContainer

@onready var full_name := $VBoxContainer/FullName as Label
@onready var age := $VBoxContainer/Age as Label
@onready var address := $VBoxContainer/Address as Label
@onready var curp := $VBoxContainer/Curp as Label


func populate(person_data: PersonDataSource, person_descriptor: PersonDescriptor) -> void:
	if person_descriptor == null or person_data == null:
		full_name.text = ""
		age.text = ""
		address.text = ""
		curp.text = ""
	else:
		full_name.text = person_descriptor.name
		age.text = str(person_descriptor.age)
		address.text = person_descriptor.address
		curp.text = person_descriptor.curp


func clear() -> void:
	populate(null, null)

extends VBoxContainer

@onready var full_name := $FullName as Label
@onready var age := $Age as Label
@onready var address := $Address as Label
@onready var curp := $Curp as Label


var person_descriptor: PersonDescriptor:
	get:
		return person_descriptor
	set(value):
		person_descriptor = value
		if value == null:
			full_name.text = ""
			age.text = ""
			address.text = ""
			curp.text = ""
		else:
			full_name.text = person_descriptor.name
			age.text = str(person_descriptor.age)
			address.text = person_descriptor.address
			curp.text = person_descriptor.curp

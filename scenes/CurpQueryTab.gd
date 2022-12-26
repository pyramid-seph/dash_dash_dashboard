extends HBoxContainer

@export var title: String

@onready var full_name := $MarginContainer/VBoxContainer/FullName as Label
@onready var age := $MarginContainer/VBoxContainer/Age as Label
@onready var address := $MarginContainer/VBoxContainer/Address as Label
@onready var curp := $MarginContainer/VBoxContainer/Curp as Label


func populate(person_data: PersonDataSource, person_descriptor: PersonDescriptor) -> void:
	if person_descriptor == null or person_data == null:
		full_name.text = ""
		age.text = ""
		address.text = ""
		curp.text = ""
	else:
		full_name.text = "NAME: %s" % person_descriptor.name
		age.text = "AGE: %s" % str(person_descriptor.age)
		address.text = "ADDRESS: %s" % person_descriptor.address
		curp.text = "ID: %s" % person_descriptor.curp


func clear() -> void:
	populate(null, null)

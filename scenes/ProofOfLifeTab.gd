extends VBoxContainer

@export var title: String

@onready var person_image := $PersonImage as PersonImage


func populate(person_data: PersonDataSource, person_descriptor: PersonDescriptor) -> void:
	if person_descriptor == null or person_data == null:
		person_image.clear()
	else:
		person_image.generate(person_data, person_descriptor)


func clear() -> void:
	populate(null, null)

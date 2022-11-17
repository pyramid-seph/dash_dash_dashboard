extends VBoxContainer

@onready var debug_text := $DebugText as Label


var person_descriptor: PersonDescriptor:
	get:
		return person_descriptor
	set(value):
		person_descriptor = value
		if person_descriptor == null:
			debug_text.text = ""
		else:
			debug_text.text = str(person_descriptor)

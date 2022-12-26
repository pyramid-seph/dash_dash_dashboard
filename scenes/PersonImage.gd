class_name PersonImage
extends CenterContainer

@onready var eyes_rect := $EyesTexture as TextureRect
@onready var head_rect := $HeadTexture as TextureRect
@onready var mouth_rect := $MouthTexture as TextureRect
@onready var nose_rect := $NoseTexture as TextureRect


func generate(person_data : PersonDataSource, person_descriptor: PersonDescriptor) -> void:
	head_rect.texture = person_data.head_types[person_descriptor.head_type]
	eyes_rect.texture = person_data.eye_types[person_descriptor.eye_type]
	mouth_rect.texture = person_data.mouth_types[person_descriptor.mouth_type]
	nose_rect.texture = person_data.nose_types[person_descriptor.nose_type]


func clear() -> void:
	head_rect.texture = null
	eyes_rect.texture = null
	mouth_rect.texture = null
	nose_rect.texture = null

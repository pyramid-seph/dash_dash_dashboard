class_name PersonDescriptor
extends RefCounted


const DESCRIPTION_BODY_TYPE = "DESCRIPTION_BODY_TYPE"
const DESCRIPTION_HEAD_TYPE = "DESCRIPTION_HEAD_TYPE"
const DESCRIPTION_EYE_TYPE = "DESCRIPTION_EYE_TYPE"
const DESCRIPTION_EYE_COLOR = "DESCRIPTION_EYE_COLOR"
const DESCRIPTION_NOSE_TYPE = "DESCRIPTION_NOSE_TYPE"
const DESCRIPTION_MOUTH_TYPE = "DESCRIPTION_MOUTH_TYPE"
const DESCRIPTION_NAME = "DESCRIPTION_NAME"
const DESCRIPTION_AGE = "DESCRIPTION_AGE"
const DESCRIPTION_ADDRESS = "DESCRIPTION_ADDRESS"
const DESCRIPTION_CURP = "DESCRIPTION_CURP"

var body_type: int = 0
var head_type: int = 0
var eye_type: int = 0
var eye_color: Color = Color.BLACK
var nose_type: int = 0
var mouth_type: int = 0
var name: String = ""
var age: int = 0
var address: String = ""
var curp: String = ""


func  _to_string() -> String:
	return "PersonDescriptor(name=\"%s\", age=%s, address=\"%s\", CURP=\"%s\",eye_color=%s)" % [name, age, address, curp, eye_color]


func is_equal_to(other: PersonDescriptor) -> bool:
	return other.body_type == body_type \
		and other.head_type == head_type \
		and other.eye_type == eye_type \
		and other.eye_color == eye_color \
		and other.nose_type == nose_type \
		and other.mouth_type == mouth_type \
		and other.name == name \
		and other.age == age \
		and other.address == address \
		and other.curp == curp


func get_differences(other: PersonDescriptor) -> Array[String]:
	var differences: Array[String] = []
	if other.body_type != body_type:
		differences.append(DESCRIPTION_BODY_TYPE)
	if other.head_type != head_type:
		differences.append(DESCRIPTION_HEAD_TYPE)
	if other.eye_type != eye_type:
		differences.append(DESCRIPTION_EYE_TYPE)
	if other.eye_color != eye_color:
		differences.append(DESCRIPTION_EYE_COLOR)
	if other.nose_type != nose_type:
		differences.append(DESCRIPTION_NOSE_TYPE)
	if other.mouth_type != mouth_type:
		differences.append(DESCRIPTION_MOUTH_TYPE)
	if other.name != name:
		differences.append(DESCRIPTION_NAME)
	if other.age != age:
		differences.append(DESCRIPTION_AGE)
	if other.address != address:
		differences.append(DESCRIPTION_ADDRESS)
	if other.curp != curp:
		differences.append(DESCRIPTION_CURP)
	return differences


func clone() -> PersonDescriptor:
	var new_person = PersonDescriptor.new()
	new_person.body_type = body_type
	new_person.head_type = head_type
	new_person.eye_type = eye_type
	new_person.eye_color = eye_color
	new_person.nose_type = nose_type
	new_person.mouth_type = mouth_type
	new_person.name = name
	new_person.age = age
	new_person.address = address
	new_person.curp = curp
	return new_person

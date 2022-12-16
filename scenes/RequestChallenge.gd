class_name RequestChallenge
extends RefCounted

var person_data_source: PersonDataSource
var curp_query_person: PersonDescriptor
var original_person: PersonDescriptor
var proof_of_life_person: PersonDescriptor

func should_be_accepted() -> bool:
	return curp_query_person.is_equal_to(original_person) && \
		proof_of_life_person.is_equal_to(original_person)


func get_life_proof_diff() -> Array[String]:
	return original_person.get_differences(proof_of_life_person)


func get_curp_query_diff() -> Array[String]:
	return original_person.get_differences(curp_query_person)

class_name RequestChallenge
extends RefCounted

var person_data_source: PersonDataSource
var curp_query_person: PersonDescriptor
var original_person: PersonDescriptor
var proof_of_life_person: PersonDescriptor

func should_be_accepted() -> bool:
	return curp_query_person.is_equal_to(original_person) && \
		proof_of_life_person.is_equal_to(original_person)

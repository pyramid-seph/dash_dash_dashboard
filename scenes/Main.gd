extends Node


enum GameState {
	PLAYING,
	GAME_OVER,
}


@export var stamina_depletion_rate: int = 0
@export var stamina_gain_rate: int = 0
@export var stamina_gain_per_correct_answer: int = 0
@export var points_per_correct_answer: int = 100

var _game_state: GameState = GameState.PLAYING
var _current_request_challenge: RequestChallenge:
	get:
		return _current_request_challenge
	set(value):
		_current_request_challenge = value
		gui.request_challenge = value

@onready var timer: Timer = $Timer
@onready var gui := $GUI
@onready var person_randomizer: PersonRandomizer = $PersonRandomizer


func _ready() -> void:
	_setup_next_request_challenge()


func _unhandled_input(event) -> void:
	if event.is_action_pressed("pause") and _game_state == GameState.PLAYING:
		get_tree().paused = !get_tree().paused
		gui.show_pause_panel(get_tree().paused)


func _create_request_challenge() -> RequestChallenge:
	var person: PersonDescriptor = person_randomizer.create_random_person()
	var challenge: RequestChallenge = RequestChallenge.new()
	challenge.original_person = person
	if randi() % 2 == 0:
		challenge.curp_query_person = person
		challenge.proof_of_life_person = person
	else:
		var other_person: PersonDescriptor
		for _i in 5:
			other_person = person_randomizer.create_random_person()
			if not other_person.is_equal_to(person):
				break
		
		if randi() % 2 == 0:
			challenge.curp_query_person = other_person
			challenge.proof_of_life_person = person
		else:
			challenge.curp_query_person = person
			challenge.proof_of_life_person = other_person
	return challenge


func _setup_next_request_challenge() -> void:
	_current_request_challenge = _create_request_challenge()


func _on_gui_on_request_rejected() -> void:
	if _current_request_challenge == null:
		print("No challenge to check. This should not happen.")
		return
	if _current_request_challenge.should_be_accepted():
		print("You lose! ")
	else:
		print("You win! ")
	_current_request_challenge = _create_request_challenge()


func _on_gui_on_request_accepted() -> void:
	if _current_request_challenge == null:
		print("No challenge to check. Skipping.")
		_setup_next_request_challenge()
		return

	if _current_request_challenge.should_be_accepted():
		print("You win! ")
	else:
		print("You lose! ")
	_setup_next_request_challenge()

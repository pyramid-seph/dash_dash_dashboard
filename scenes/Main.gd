extends Node


enum GameState {
	PLAYING,
	GAME_OVER,
}


@export var stamina_sec: float = 60.0
@export var stamina_gain_sec: float = 10.0
@export var stamina_lose_sec: float = 5.0
@export var base_points_successful_request: int = 100

var _max_combo: int = 0
var _max_combo_multiplier: float = 0
var _correct_guesses: int = 0
var _score: int = 0
var _game_state: GameState = GameState.PLAYING
var _current_request_challenge: RequestChallenge:
	get:
		return _current_request_challenge
	set(value):
		_current_request_challenge = value
		gameplay_gui.request_challenge = value

@onready var gameplay_gui := $GameplayGui as GameplayGui
@onready var person_randomizer := $PersonRandomizer as PersonRandomizer
@onready var stamina_timer := $StaminaTimer as ClampedTime
@onready var request_combo_mngr := $RequestComboManager as ComboManager


func _ready() -> void:
	_score = 0
	_correct_guesses = 0
	_max_combo_multiplier = request_combo_mngr.MIN_MULTIPLIER
	_max_combo = 0
	_setup_next_request_challenge()
	gameplay_gui.hide_results()
	stamina_timer.start(stamina_sec)
	gameplay_gui.update_score(_score)
	gameplay_gui.update_max_multiplier(_max_combo_multiplier)
	gameplay_gui.update_max_combo(_max_combo)
	gameplay_gui.update_correct_guessess(_correct_guesses)
	request_combo_mngr.combo_started.connect(func(_a, b): print("Consecutive: %s" % b))
	request_combo_mngr.combo_extended.connect(func(_a, b): print("Consecutive: %s" % b))


func _unhandled_input(event) -> void:
	if event.is_action_pressed("pause") and _game_state == GameState.PLAYING:
		get_tree().paused = !get_tree().paused
		gameplay_gui.show_pause_panel(get_tree().paused)


func _process(_delta) -> void:
	gameplay_gui.update_stamina_meter(stamina_timer.max_wait_time, stamina_timer.time_left)
	gameplay_gui.update_request_combo_counter(request_combo_mngr.time_left,\
		request_combo_mngr.multiplier, request_combo_mngr.consecutive_extensions)


func _create_request_challenge() -> RequestChallenge:
	var person: PersonDescriptor = person_randomizer.create_random_person()
	var challenge: RequestChallenge = RequestChallenge.new()
	challenge.person_data_source = person_randomizer.person_data_source
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
	if _game_state != GameState.GAME_OVER:
		_current_request_challenge = _create_request_challenge()


func _on_correct_request_guess() -> void:
	stamina_timer.add_time(stamina_gain_sec)
	request_combo_mngr.extend_combo_time()
	var points: int = int(
		base_points_successful_request * request_combo_mngr.multiplier
	)
	_score += points
	_correct_guesses += 1
	if _max_combo_multiplier < request_combo_mngr.multiplier:
		_max_combo_multiplier = request_combo_mngr.multiplier
		gameplay_gui.update_max_multiplier(_max_combo_multiplier)
	if _max_combo < request_combo_mngr.consecutive_extensions:
		_max_combo = request_combo_mngr.consecutive_extensions
		gameplay_gui.update_max_combo(_max_combo)
		
	gameplay_gui.update_score(_score)
	gameplay_gui.update_correct_guessess(_correct_guesses)


func _on_failed_request_guess() -> void:
	stamina_timer.remove_time(stamina_lose_sec)
	request_combo_mngr.break_combo()


func _on_gameplay_gui_on_request_rejected() -> void:
	if _game_state != GameState.PLAYING: return
	
	if _current_request_challenge == null:
		print("No challenge to check. Creating a new one.")
		_setup_next_request_challenge()
		return
		
	if _current_request_challenge.should_be_accepted():
		_on_failed_request_guess()
	else:
		_on_correct_request_guess()
	_setup_next_request_challenge()


func _on_gameplay_gui_on_request_accepted() -> void:
	if _game_state != GameState.PLAYING: return
	
	if _current_request_challenge == null:
		print("No challenge to check. Creating a new one.")
		_setup_next_request_challenge()
		return
		
	if _current_request_challenge.should_be_accepted():
		_on_correct_request_guess()
	else:
		_on_failed_request_guess()
	_setup_next_request_challenge()


func _on_stamina_timer_timeout() -> void:
	_game_state = GameState.GAME_OVER
	var bonus_points: int = int(_max_combo * _max_combo_multiplier * base_points_successful_request)
	_score += bonus_points
	gameplay_gui.show_results(_max_combo, _max_combo_multiplier, bonus_points, _score)


func _on_request_combo_manager_combo_started(_multiplier, _consecutive_extensions) -> void:
	gameplay_gui.show_request_combo_counter(true)


func _on_request_combo_manager_combo_broken():
	gameplay_gui.show_request_combo_counter(false)

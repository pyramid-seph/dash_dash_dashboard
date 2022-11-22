extends Node


enum GameState {
	Playing,
	GameOver,
}


@export var initial_stamina_sec: float = 60.0
@export var stamina_gain_sec: float = 10.0
@export var stamina_lose_sec: float = 5.0

var _game_state: GameState = GameState.Playing
var _current_request_challenge: RequestChallenge:
	get:
		return _current_request_challenge
	set(value):
		_current_request_challenge = value
		gui.request_challenge = value

@onready var timer: Timer = $Timer
@onready var gui := $GUI
@onready var person_randomizer: PersonRandomizer = $PersonRandomizer
@onready var stamina_timer = $StaminaTimer as Timer


func _ready() -> void:
	_setup_next_request_challenge()
	stamina_timer.start(initial_stamina_sec)


func _unhandled_input(event) -> void:
	if event.is_action_pressed("pause") and _game_state == GameState.Playing:
		get_tree().paused = !get_tree().paused
		gui.show_pause_panel(get_tree().paused)


func _process(_delta) -> void:
	gui.update_stamina_meter(stamina_timer.time_left)


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
	if not stamina_timer.is_stopped() and _game_state != GameState.GameOver:
		_current_request_challenge = _create_request_challenge()


func extend_stamina(time_sec: float = stamina_gain_sec) -> void:
	var new_stamina = minf(stamina_timer.time_left + time_sec, initial_stamina_sec)
	stamina_timer.start(new_stamina)


func deplete_stamina(time_sec: float = stamina_lose_sec) -> void:
	var new_stamina = stamina_timer.time_left - time_sec
	if new_stamina <= 0.0:
		stamina_timer.stop()
	else:
		stamina_timer.start(new_stamina)


func _on_gui_on_request_rejected() -> void:
	if _current_request_challenge == null:
		print("No challenge to check. Creating a new one.")
		_setup_next_request_challenge()
		return
		
	if _current_request_challenge.should_be_accepted():
		deplete_stamina()
	else:
		extend_stamina()
	_setup_next_request_challenge()


func _on_gui_on_request_accepted() -> void:
	if _game_state != GameState.Playing: return
	
	if _current_request_challenge == null:
		print("No challenge to check. Creating a new one.")
		_setup_next_request_challenge()
		return
		
	if _current_request_challenge.should_be_accepted():
		extend_stamina()
	else:
		deplete_stamina()
		_setup_next_request_challenge()


func _on_stamina_timer_timeout():
	_game_state = GameState.GameOver

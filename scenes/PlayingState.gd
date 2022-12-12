extends GameState


func _on_enter() -> void:
	_reset_game_state()
	_setup_connections()
	_setup_next_challenge()
	_setup_gui()
	game.stamina_timer.start(game.stamina_sec)


func _update(_delta: float) -> void:
	game.gameplay_gui.update_stamina_meter(
		game.stamina_timer.max_wait_time,
		game.stamina_timer.time_left
	)
	game.gameplay_gui.request_combo_counter.update(
		game.combo_mngr.duration_sec,
		game.combo_mngr.time_left
	)


func _handle_input( event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		state_machine.interrupt_with(state_machine.pause_state)


func _on_exit() -> void:
	game.combo_mngr.break_combo()
	_destroy_connections()
	game.gameplay_gui.change_game_screen_visibility(false)


func _reset_game_state() -> void:
	game.score = 0
	game.correct_guesses = 0
	game.max_combo_multiplier = game.combo_mngr.MIN_MULTIPLIER
	game.max_combo = 0	
	# Hi score will not be reset


func _setup_gui() -> void:
	game.gameplay_gui.request_combo_counter.show_combo_bar(false)
	game.gameplay_gui.update_max_multiplier(game.max_combo_multiplier)
	game.gameplay_gui.update_max_combo(game.max_combo)
	game.gameplay_gui.update_correct_guessess(game.correct_guesses)
	game.gameplay_gui.update_score(game.score)
	game.gameplay_gui.change_game_screen_visibility(true)


func _setup_connections() -> void:
	game.stamina_timer.timeout.connect(_on_stamina_timer_timeout)
	game.combo_mngr.combo_started.connect(_on_combo_started)
	game.combo_mngr.combo_extended.connect(_on_combo_extended)
	game.combo_mngr.combo_broken.connect(_on_combo_broken)
	game.gameplay_gui.request_accepted.connect(_on_request_accepted)
	game.gameplay_gui.request_rejected.connect(_on_request_rejected)


func _destroy_connections() -> void:
	game.stamina_timer.timeout.disconnect(_on_stamina_timer_timeout)
	game.combo_mngr.combo_started.disconnect(_on_combo_started)
	game.combo_mngr.combo_extended.disconnect(_on_combo_extended)
	game.combo_mngr.combo_broken.disconnect(_on_combo_broken)
	game.gameplay_gui.request_accepted.disconnect(_on_request_accepted)
	game.gameplay_gui.request_rejected.disconnect(_on_request_rejected)


func _create_request_challenge() -> RequestChallenge:
	var person: PersonDescriptor = game.person_randomizer.create_random_person()
	var challenge: RequestChallenge = RequestChallenge.new()
	challenge.person_data_source = game.person_randomizer.person_data_source
	challenge.original_person = person
	if randi() % 2 == 0:
		challenge.curp_query_person = person
		challenge.proof_of_life_person = person
	else:
		var other_person: PersonDescriptor
		for _i in 5:
			other_person = game.person_randomizer.create_random_person()
			if not other_person.is_equal_to(person):
				break
		
		if randi() % 2 == 0:
			challenge.curp_query_person = other_person
			challenge.proof_of_life_person = person
		else:
			challenge.curp_query_person = person
			challenge.proof_of_life_person = other_person
	return challenge


func _setup_next_challenge() -> void:
	game.current_challenge = _create_request_challenge()


func _on_stamina_timer_timeout() -> void:
	state_machine.change_state(state_machine.game_over_state)


func _on_combo_started( multiplier, combo) -> void:
	game.gameplay_gui.request_combo_counter.show_combo_bar(true)
	game.gameplay_gui.request_combo_counter.combo = combo
	game.gameplay_gui.request_combo_counter.multiplier = multiplier


func _on_combo_extended( multiplier, combo) -> void:
	game.gameplay_gui.request_combo_counter.combo = combo
	game.gameplay_gui.request_combo_counter.multiplier = multiplier


func _on_combo_broken() -> void:
	game.gameplay_gui.request_combo_counter.show_combo_bar(false)


func _on_correct_request_guess() -> void:
	game.stamina_timer.add_time(game.stamina_gain_sec)
	game.combo_mngr.extend_combo_time()
	var points: int = int(
		game.base_points_correct_guess * game.combo_mngr.multiplier
	)
	game.score += points
	game.correct_guesses += 1
	if game.max_combo_multiplier < game.combo_mngr.multiplier:
		game.max_combo_multiplier = game.combo_mngr.multiplier
		game.gameplay_gui.update_max_multiplier(game.max_combo_multiplier)
	if game.max_combo < game.combo_mngr.consecutive_extensions:
		game.max_combo = game.combo_mngr.consecutive_extensions
		game.gameplay_gui.update_max_combo(game.max_combo)
	game.gameplay_gui.update_score(game.score)
	game.gameplay_gui.update_correct_guessess(game.correct_guesses)


func _on_failed_request_guess() -> void:
	game.stamina_timer.remove_time(game.stamina_lose_sec)
	game.combo_mngr.break_combo()


func _on_request_rejected() -> void:
	if game.current_challenge == null:
		print("No challenge to check. Creating a new one.")
		_setup_next_challenge()
		return
		
	if game.current_challenge.should_be_accepted():
		_on_failed_request_guess()
	else:
		_on_correct_request_guess()
	_setup_next_challenge()


func _on_request_accepted() -> void:
	if game.current_challenge == null:
		print("No challenge to check. Creating a new one.")
		_setup_next_challenge()
		return
		
	if game.current_challenge.should_be_accepted():
		_on_correct_request_guess()
	else:
		_on_failed_request_guess()
	_setup_next_challenge()

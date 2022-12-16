class_name GameplayGui
extends Control

signal request_accepted
signal request_rejected

@onready var curp_query_tab = %CurpQueryTab
@onready var user_data_tab = %UserDataTab
@onready var proof_of_life_tab = %ProofOfLifeTab
@onready var debug := $DebugPanel/Debug as Label
@onready var pause_panel = $PausePanel as PanelContainer
@onready var game_over_results = $GameOverResults as PanelContainer
@onready var stamina_bar := %StaminaTimer as StaminaBar
@onready var request_combo_counter := %RequestComboCounter as ComboBar
@onready var score_panel := %ScorePanel as ScorePanel
@onready var title_screen := $TitleScreen
@onready var quote_panel := $QuotePanel
@onready var instructions_panel := $IntructionsPanel
@onready var error_explanation_panel := $ErrorExplanationPanel
@onready var correct_panel := $CorrectPanel
@onready var game_panel := $GameContainer
@onready var incorrect_guess_panel := %IncorrectGuessPanel
@onready var correct_guess_panel := %CorrectGuessPanel
@onready var loading_next_challenge := %LoadingNextChallenge
@onready var challenge_container := %ChallengeContainer


var request_challenge: RequestChallenge:
	get:
		return request_challenge
	set(value):
		request_challenge = value
		if value == null:
			curp_query_tab.clear()
			user_data_tab.clear()
			proof_of_life_tab.clear()
			debug.text = "No challenge hass been set"
		else:
			curp_query_tab.populate(value.person_data_source, value.curp_query_person)
			user_data_tab.populate(value.person_data_source, value.original_person)
			proof_of_life_tab.populate(value.person_data_source, value.proof_of_life_person)
			debug.text = "\n".join([str(value.original_person), "accept?: %s" % str(value.should_be_accepted())])


func stop_next_challenge() -> void:
	loading_next_challenge.stop()


func prepare_next_challenge(duration_sec: float, is_correct: bool, challenge: RequestChallenge) -> void:
	challenge_container.visible = false
	loading_next_challenge.start(duration_sec, is_correct, challenge)


func change_game_screen_visibility(value: bool) -> void:
	game_panel.visible = value


func change_title_screen_visibility(value: bool) -> void:
	title_screen.visible = value


func change_quote_visibility(value: bool) -> void:
	quote_panel.visible = value


func change_instructions_visibility(value: bool) -> void:
	instructions_panel.visible = value


func change_correct_panel_visibility(value: bool) -> void:
	correct_panel.visible = value


func update_score(value: int) -> void:
	score_panel.score = value


func update_hi_score(value: int) -> void:
	score_panel.hi_score = value


func update_max_combo(value: int) -> void:
	score_panel.max_combo = value


func update_max_multiplier(value: float) -> void:
	score_panel.max_multiplier = value


func update_correct_guessess(value: int) -> void:
	score_panel.correct_guesses = value


func show_pause_panel(paused: bool) -> void:
	pause_panel.visible = paused


func show_results(max_combo: int, max_multiplier: float, bonus_points: int, total_score: int, old_score: int, base_bonus_points: int) -> void:
	game_over_results.show_results(max_combo, max_multiplier, bonus_points, total_score, old_score, base_bonus_points)


func hide_results() -> void:
	game_over_results.hide_results()


func update_stamina_meter(max_stamina: float, curr_stamina: float) -> void:
	stamina_bar.update(max_stamina, curr_stamina)


func _on_accept_button_pressed() -> void:
	request_accepted.emit()


func _on_reject_button_pressed() -> void:
	request_rejected.emit()


func _on_loading_next_challenge_timeout() -> void:
	challenge_container.visible = true

class_name GameplayGui
extends Control

signal on_request_accepted
signal on_request_rejected

@onready var curp_query_tab = %CurpQueryTab
@onready var user_data_tab = %UserDataTab
@onready var proof_of_life_tab = %ProofOfLifeTab
@onready var debug := $DebugPanel/Debug as Label
@onready var pause_panel = $PausePanel as PanelContainer
@onready var game_over_results = $GameOverResults as PanelContainer
@onready var stamina_bar := %StaminaTimer as StaminaBar
@onready var request_combo_counter := %RequestComboCounter as ComboBar
@onready var score := %Score as Label
@onready var max_combo_label := $PanelContainer/VBoxContainer/HUD/MaxCombo as Label
@onready var max_mult_label := $PanelContainer/VBoxContainer/HUD/MaxMultiplier as Label
@onready var correct_guesses_label := $PanelContainer/VBoxContainer/HUD/Correct as Label


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


func update_score(points: int) -> void:
	score.text = "Score: %s" % points


func update_max_combo(value: int) -> void:
	max_combo_label.text = "MAX C: %s" % value


func update_max_multiplier(value: float) -> void:
	max_mult_label.text = "MAX M: %s" % value


func update_correct_guessess(value: int) -> void:
	correct_guesses_label.text = "CG: %s" % value


func show_pause_panel(paused: bool) -> void:
	pause_panel.visible = paused


func show_results(max_combo: int, max_multiplier: float, bonus_points: int, total_score: int) -> void:
	game_over_results.show_results(max_combo, max_multiplier, bonus_points, total_score)


func hide_results() -> void:
	game_over_results.hide_results()


func update_stamina_meter(max_stamina: float, curr_stamina: float) -> void:
	stamina_bar.update(max_stamina, curr_stamina)


func _on_accept_button_pressed() -> void:
	on_request_accepted.emit()


func _on_reject_button_pressed() -> void:
	on_request_rejected.emit()

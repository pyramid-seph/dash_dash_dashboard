class_name GameplayGui
extends Control

signal on_request_accepted
signal on_request_rejected

@onready var curp_query_tab = %CurpQueryTab
@onready var user_data_tab = %UserDataTab
@onready var proof_of_life_tab = %ProofOfLifeTab
@onready var debug := $DebugPanel/Debug as Label
@onready var pause_panel = $PausePanel
@onready var cheems := %StaminaTimer as Label
@onready var request_combo_counter := %RequestComboCounter as Label
@onready var score := %Score as Label


var request_challenge: RequestChallenge:
	get:
		return request_challenge
	set(value):
		request_challenge = value
		if value == null:
			curp_query_tab.person_descriptor = null
			user_data_tab.person_descriptor = null
			proof_of_life_tab.person_descriptor = null
			debug.text = "No challenge hass been set"
		else:
			curp_query_tab.person_descriptor = value.curp_query_person
			user_data_tab.person_descriptor = value.original_person
			proof_of_life_tab.person_descriptor = value.proof_of_life_person
			debug.text = "\n".join([str(value.original_person), "accept?: %s" % str(value.should_be_accepted())])


func update_score(points: int) -> void:
	score.text = "Score: %s" % points


func update_request_combo_counter(time_left: float, multiplier: float) -> void:
	request_combo_counter.text = "Combo: %s (%s)" % [time_left, multiplier]


func show_request_combo_counter(should_show: bool) -> void:
	request_combo_counter.visible = should_show


func show_pause_panel(paused: bool) -> void:
	pause_panel.visible = paused


func update_stamina_meter(stamina: float) -> void:
	cheems.text = str(int(stamina * 100.0))


func _on_accept_button_pressed() -> void:
	on_request_accepted.emit()


func _on_reject_button_pressed() -> void:
	on_request_rejected.emit()

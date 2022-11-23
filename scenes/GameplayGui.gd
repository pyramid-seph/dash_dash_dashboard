class_name GameplayGui
extends Control

signal on_request_accepted
signal on_request_rejected

@onready var curp_query_tab = %CurpQueryTab
@onready var user_data_tab = %UserDataTab
@onready var proof_of_life_tab = %ProofOfLifeTab
@onready var debug := $DebugPanel/Debug as Label
@onready var pause_panel = $PausePanel
@onready var cheems := $PanelContainer/VBoxContainer/HUD/Cheems as Label


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


func show_pause_panel(paused: bool) -> void:
	pause_panel.visible = paused


func update_stamina_meter(stamina: float) -> void:
	cheems.text = str(int(stamina * 100.0))


func _on_accept_button_pressed() -> void:
	on_request_accepted.emit()


func _on_reject_button_pressed() -> void:
	on_request_rejected.emit()

extends GameState


func _on_enter() -> void:
	game.gameplay_gui.change_quote_visibility(true)


func _handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("accept"):
		state_machine.change_state(state_machine.playing_state)


func _on_exit() -> void:
	game.gameplay_gui.change_quote_visibility(false)

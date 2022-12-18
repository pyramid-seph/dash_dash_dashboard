extends GameState

func _on_enter() -> void:
	game.gameplay_gui.change_instructions_visibility(true)


func _handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("accept"):
		SfxManager.play(game.accept_sfx)
		state_machine.change_state(state_machine.quote_state)


func _on_exit() -> void:
	game.gameplay_gui.change_instructions_visibility(false)

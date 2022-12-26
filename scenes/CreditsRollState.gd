extends GameState

func _on_enter() -> void:
	game.gameplay_gui.change_credits_container_visibility(true)


func _handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("cancel"):
		SfxManager.play(game.cancel_sfx)
		state_machine.change_state(state_machine.title_screen_state)


func _on_exit() -> void:
	game.gameplay_gui.change_credits_container_visibility(false)

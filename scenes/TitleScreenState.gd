extends GameState


func _on_enter() -> void:
	game.gameplay_gui.change_title_screen_visibility(true)


func _handle_input(event: InputEvent) -> void:
	if OS.get_name() != "Web" && event.is_action_pressed("exit"):
		SfxManager.play(game.cancel_sfx)
		get_tree().quit()
	elif event.is_action_pressed("show_credits"):
		SfxManager.play(game.accept_sfx)
		state_machine.change_state(state_machine.credits_roll_state)
	elif event.is_action_pressed("accept"):
		SfxManager.play(game.accept_sfx)
		state_machine.change_state(state_machine.instructions_state)


func _on_exit() -> void:
	game.gameplay_gui.change_title_screen_visibility(false)

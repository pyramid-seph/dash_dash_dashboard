extends GameState


func _on_enter() -> void:
	get_tree().paused = true
	game.gameplay_gui.show_pause_panel(true)


func _handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		state_machine.revert_to_interrupted_state()
	if event.is_action_pressed("exit"):
		SfxManager.play(game.cancel_sfx)
		state_machine.revert_to_interrupted_state()
		state_machine.change_state(state_machine.title_screen_state)


func _on_exit() -> void:
	get_tree().paused = false
	game.gameplay_gui.show_pause_panel(false)

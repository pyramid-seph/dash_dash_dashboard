extends GameState


func _on_enter() -> void:
	var bonus_points = int(game.max_combo * game.max_combo_multiplier * game.base_bonus_points)
	var old_score = game.score
	game.score += bonus_points
	GameData.hi_score = game.hi_score
	GameData.save()
	game.gameplay_gui.show_results(game.max_combo, game.max_combo_multiplier, bonus_points, game.score, old_score, game.base_bonus_points)


func _handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("cancel"):
		SfxManager.play(game.cancel_sfx)
		state_machine.change_state(state_machine.title_screen_state)
	elif event.is_action_pressed("accept"):
		state_machine.change_state(state_machine.playing_state)


func _on_exit() -> void:
	game.gameplay_gui.hide_results()

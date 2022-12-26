class_name GameState
extends Node

var game: Game
var state_machine: GameStateMachine:
	get:
		return game.state_machine


func _on_enter() -> void:
	pass


func _update(_delta: float) -> void:
	pass


func _handle_input(_event: InputEvent) -> void:
	pass


func _on_exit() -> void:
	pass

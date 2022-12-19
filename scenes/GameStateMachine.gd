class_name GameStateMachine
extends Node


var _previous_state: GameState
var _curr_state: GameState


@onready var title_screen_state: GameState = $TitleScreenState
@onready var instructions_state: GameState = $InstructionsState
@onready var quote_state: GameState = $QuoteState
@onready var pause_state: GameState = $PauseState
@onready var playing_state: GameState = $PlayingState
@onready var game_over_state: GameState = $GameOverState


func _process(delta: float) -> void:
	if _curr_state: _curr_state._update(delta)


func _unhandled_input(event: InputEvent) -> void:
	if _curr_state: _curr_state._handle_input(event)


func change_state(game_state: GameState) -> void:
	# TODO Do not change if the state does not change
	if _curr_state: _curr_state._on_exit()
	_curr_state = game_state
	_curr_state._on_enter()


func interrupt_with(game_state: GameState) -> void:
	_previous_state = _curr_state
	_curr_state = game_state
	_curr_state._on_enter()


func revert_to_interrupted_state() -> void:
	if not _previous_state: return
	
	if _curr_state:
		_curr_state._on_exit()
	_curr_state = _previous_state
	_previous_state = null


func start(game: Game) -> void:
	for child in get_children():
		child.game = game
	change_state(title_screen_state)

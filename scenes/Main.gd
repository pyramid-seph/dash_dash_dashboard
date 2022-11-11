extends Node

#05. signals

#06. enums
enum GameState {
	PLAYING,
	GAME_OVER,
}

#07. constants
#08. exported variables

@export var stamina_depletion_rate: int = 0
@export var stamina_gain_rate: int = 0
@export var stamina_gain_per_correct_answer: int = 0
@export var points_per_correct_answer: int = 100

#09. public variables

#10. private variables
var _game_state: GameState = GameState.PLAYING

#11. onready variables
@onready var world: Node2D = $World
@onready var timer: Timer = $Timer
@onready var ui: Node = $Ui
@onready var person_randomizer: PersonRandomizer = $PersonRandomizer

#12. optional built-in virtual _init method

#13. built-in virtual _ready method
func _ready() -> void:
	# Randomize person
	_create_challenge()
	# Create check ui
		# decide if curp check is correct. Checking CURP requires some time
			# if not, fake one or more data
		# decide if ine is correct
			# if not, fake one or more data
	# Wait for the user to mark if it is right
	# Evaluate their decision
	# If right add points
	# if not right, deduce some stamina
	# game ends if time runs out
	pass

#14. remaining built-in virtual methods
func _unhandled_input(event):
	if event.is_action_pressed("pause") and _game_state == GameState.PLAYING:
		get_tree().paused = !get_tree().paused


#15. public methods
#16. private methods
func _create_challenge() -> void:
	pass

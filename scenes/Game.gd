class_name Game
extends Node


@export var bgm: AudioStream
@export var accept_sfx: AudioStream
@export var cancel_sfx: AudioStream
@export var restrict_tries: int = 0
@export var initial_delay_sec: float = 3.0
@export var stamina_sec: float = 60.0
@export var stamina_gain_sec: float = 10.0
@export var stamina_lose_sec: float = 5.0
@export var next_challenge_delay: float = 1.0
@export var base_points_correct_guess: int = 100
@export var base_bonus_points: int = 500

var max_combo: int = 0
var max_combo_multiplier: float = 0
var correct_guesses: int = 0
var hi_score: int = 0:
	set(new_value):
		hi_score = new_value
		gameplay_gui.update_hi_score(hi_score)
var score: int = 0:
	set(new_value):
		score = new_value
		hi_score = maxi(hi_score, score)
var current_challenge: RequestChallenge:
	get:
		return current_challenge
	set(value):
		current_challenge = value
		gameplay_gui.request_challenge = value
var curr_tries: int = 0

@onready var gameplay_gui := $GameplayGui as GameplayGui
@onready var person_randomizer := $PersonRandomizer as PersonRandomizer
@onready var stamina_timer := $StaminaTimer as ClampedTime
@onready var combo_mngr := $ComboManager as ComboManager
@onready var state_machine: GameStateMachine = $GameStateMachine
@onready var music_player: AudioStreamPlayer = $MusicPlayer


func _ready():
	hi_score = GameData.hi_score
	state_machine.start(self)

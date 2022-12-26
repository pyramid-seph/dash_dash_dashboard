class_name ScorePanel
extends VBoxContainer

@onready var score_label := $ScoreLabel as Label
@onready var hi_score_label := $HiScoreLabel as Label
@onready var correct_guesses_label := $CorrectGuessesLabel as Label
@onready var max_combo_label := %MaxComboLabel as Label
@onready var max_multiplier_label := %MaxMultiplierLabel as Label


var score: int:
	set(new_value):
		score = new_value
		score_label.text = "%.0f" % score

var hi_score: int:
	set(new_value):
		hi_score = new_value
		hi_score_label.text = "HI - %.0f" % hi_score

var correct_guesses: int:
	set(new_value):
		correct_guesses = new_value
		correct_guesses_label.text = "%.0f" % correct_guesses

var max_combo: int:
	set(new_value):
		max_combo = new_value
		max_combo_label.text = "%2.0f" % max_combo

var max_multiplier: float:
	set(new_value):
		max_multiplier = new_value
		max_multiplier_label.text = "%.2f" % max_multiplier

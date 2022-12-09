extends PanelContainer


@onready var max_combo_label := %MaxCombo as Label
@onready var max_multiplier_label := %MaxMultiplier as Label
@onready var bonus_points_label := %BonusPoints as Label
@onready var total_score_label := %TotalScore as Label


func show_results(max_combo: int, max_multiplier: float, bonus_points: int, total_score: int, old_score: int) -> void:
	max_combo_label.text = "MAX COMBO: %s" % max_combo
	max_multiplier_label.text = "MAX MULT: %s" % max_multiplier
	bonus_points_label.text = "Bonus! (MAX COMBO x MAX MULT x 100): %s" % bonus_points
	total_score_label.text = "Total Score: %s + %s = %s" % [old_score, bonus_points, total_score]
	visible = true

func hide_results() -> void:
	visible = false

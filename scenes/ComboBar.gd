class_name ComboBar
extends HBoxContainer


@onready var progress_bar := $VBoxContainer/ProgressBar as TextureProgressBar
@onready var multiplier_label := $MultiplierLabel as Label


var multiplier: float:
	set(new_value):
		multiplier = new_value
		_change_multiplier_label()

var combo: int:
	set(new_value):
		combo = new_value
		_change_multiplier_label()


func _change_multiplier_label():
	multiplier_label.text = "%4.0f x %.2f" % [combo, multiplier]


func update(max_val: float, curr_val: float) -> void:
	progress_bar.value = curr_val / max_val * progress_bar.max_value

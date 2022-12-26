class_name StaminaBar
extends VBoxContainer


@onready var progress_bar := $ProgressBar as TextureProgressBar


func update(max_val: float, curr_val: float) -> void:
	progress_bar.value = curr_val / max_val * progress_bar.max_value

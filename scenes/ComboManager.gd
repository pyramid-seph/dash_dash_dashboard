class_name ComboManager
extends Node


signal combo_started(multiplier, consecutive_extensions)
signal combo_extended(multiplier, consecutive_extensions)
signal combo_broken


const MULTIPLIER_MIN: float = 1.0

@export var duration_sec: float = 1.0
@export var max_multiplier: float = 1.0
@export_range(0, 1) var multiplier_delta: float = 0.2

var _is_active: bool = false
var _consecutive_extensions: int = 0
var _multiplier:  float = 1.0:
	set(new_value):
		_multiplier = minf(new_value, max_multiplier)

var consecutive_extensions: int:
	get:
		return _consecutive_extensions
var multiplier: float:
	get:
		return _multiplier
var time_left: float:
	get:
		return timer.time_left

@onready var timer := $ClampedTime as ClampedTime


func break_combo() -> void:
	if _is_active:
		combo_broken.emit()
	_is_active = false
	timer.stop()


func extend_combo_time() -> void:
	if _is_active:
		timer.start(duration_sec)
		_consecutive_extensions += 1 
		_multiplier += multiplier_delta
		combo_extended.emit(_multiplier, _consecutive_extensions)
	else:
		_is_active = true
		_multiplier = MULTIPLIER_MIN
		_consecutive_extensions = 0
		timer.start(duration_sec)
		combo_started.emit(_multiplier, _consecutive_extensions)


func _on_clamped_time_timeout() -> void:
	combo_broken.emit()
	_is_active = false

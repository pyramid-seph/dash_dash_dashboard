class_name TimedClampedValue
extends Node


signal on_value_changed(new_value)
signal on_total_depletion(new_value)
signal on_total_increment(new_value)


enum ChangeType { Deplete, Increment }
enum Status { Stopped, Started }


@export var min_value: float = 0.0:
	set(new_value):
		min_value = minf(new_value, max_value)
	get:
		return min_value
@export var max_value: float = 1.0:
	set(new_value):
		max_value = maxf(new_value, min_value)
	get:
		return max_value
@export var initial_value: float = 1.0:
	set(new_value):
		initial_value = clampf(new_value, min_value, max_value)
	get:
		return initial_value
@export var speed: float = 0.2
@export var time_sec_between_change_signals: float = 1.0
@export var change_type: ChangeType = ChangeType.Deplete
@export var auto_start: bool = false


var current_value: float = 1.0:
	set(value):
		current_value = clampf(value, min_value, max_value)
		emit_signal("on_value_changed", current_value)
		match change_type:
			ChangeType.Deplete:
				if is_totally_depleted():
					emit_signal("on_total_depletion", current_value)
					stop()
			ChangeType.Increment:
				if is_totally_incremented():
					emit_signal("on_total_increment", current_value)
					stop()
			_:
				print_debug("Unknown status. Will forcefully stop")
				stop()
	get:
		return current_value

var _status: Status = Status.Stopped


func _ready() -> void:
	if auto_start: start()


func _process(delta) -> void:
	if is_stopped(): return
	
	match change_type:
		ChangeType.Deplete:
			current_value -= speed * delta
		ChangeType.Increment:
			current_value += speed * delta
		_:
			print_debug("Unknown status. Will forcefully stop.")
			stop()


func start(new_initial_value: float = initial_value) -> void:
	stop()
	if new_initial_value != initial_value:
		initial_value = new_initial_value
	current_value = initial_value
	_status = Status.Started


func stop() -> void:
	_status = Status.Stopped


func is_stopped() -> bool:
	return _status == Status.Stopped


func is_started() -> bool:
	return _status == Status.Started


func is_totally_depleted() -> bool:
	return is_equal_approx(current_value, min_value)


func is_totally_incremented() -> bool:
	return is_equal_approx(current_value, max_value)

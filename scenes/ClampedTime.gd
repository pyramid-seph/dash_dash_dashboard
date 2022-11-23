class_name ClampedTime
extends Node


signal timeout


@export var max_wait_time: float = 1.0

var time_left: float:
	get:
		return timer.time_left

var paused: bool:
	set(new_value):
		timer.paused = new_value
	get:
		return timer.paused

@onready var timer := $Timer as Timer


func start(time_sec: float = max_wait_time) -> void:
	if paused:
		print_debug("Ignored start() because timer is paused: %s" % time_sec)
		return
	if time_sec > 0:
		max_wait_time = time_sec
		timer.start(time_sec)
	else:
		print_debug("Ignored start() because time_sec is negative or zero: %s" % time_sec)


func stop() -> void:
	timer.stop()


func is_stopped() -> bool:
	return timer.is_stopped()


func add_time(time_sec: float) -> void:
	if time_sec < 0.0:
		remove_time(time_sec)
		return
	var new_time_sec = minf(time_left + time_sec, max_wait_time)
	timer.start(new_time_sec)


func remove_time(time_sec: float) -> void:
	var new_time_sec = time_left - time_sec
	if new_time_sec > 0.05:
		timer.start(new_time_sec)
	else:
		stop()
		_on_timer_timeout()


func _on_timer_timeout() -> void:
	timeout.emit()

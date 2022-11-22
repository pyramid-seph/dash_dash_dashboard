class_name ClampedTime
extends Node

signal on_clamped_timer_timeout(max_wait_time)


@export var max_wait_time: float = 60.0
@export var wait_time: float = 60.0:
	set(new_value):
		timer.wait_time = minf(new_value, max_wait_time)
	get:
		return timer.wait_time
@export var one_shot: bool:
	set(new_value):
		timer.one_shot = new_value
	get:
		return timer.one_shot
@export var auto_start: bool = false:
	set(new_value):
		timer.auto_start = new_value
	get:
		return timer.auto_start

var time_left: float:
	set(new_value):
		timer.start(minf(new_value, max_wait_time))
	get:
		return timer.time_left

@onready var timer := $Timer as Timer


func start(time_sec: float = -1.0) -> void:
	if not time_sec < 0:
		wait_time = time_sec
	timer.start(wait_time)


func stop() -> void:
	timer.stop()


func is_stopped() -> bool:
	return timer.is_stopped()


func _on_timer_timeout():
	if not Engine.is_editor_hint(): return
	on_clamped_timer_timeout.emit(max_wait_time)

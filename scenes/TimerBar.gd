extends TextureProgressBar


signal timeout


@export var wait_time_sec: float = 1.0
@export var auto_start: bool = false

@onready var timer := $Timer as Timer


func _ready() -> void:
	if auto_start: start()


func _process(_delta) -> void:
	if timer.is_stopped(): return
	value = timer.time_left / timer.wait_time * max_value


func start(time_sec: float = wait_time_sec) -> void:
	timer.start(time_sec)
	wait_time_sec = timer.wait_time


func stop() -> void:
	timer.stop()


func pause(is_paused: bool) -> void:
	timer.paused = is_paused


func _on_timer_timeout() -> void:
	timeout.emit()

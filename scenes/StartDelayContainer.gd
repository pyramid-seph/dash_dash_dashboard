extends CenterContainer


signal timeout


@export var tick_sfx: AudioStream
@export var bang_sfx: AudioStream

var _curr_second: int = -1

@onready var delay_label := $DelayLabel as Label
@onready var timer := $DelayLabel/Timer as Timer


func _process(_delta: float) -> void:
	if timer.is_stopped(): return
	var old_curr_second = _curr_second
	_curr_second = ceili(timer.time_left)
	delay_label.text = str(_curr_second)
	if old_curr_second != _curr_second:
		SfxManager.play(tick_sfx)


func start(time_sec: float) -> void:
	visible = true
	timer.start(time_sec)
	_curr_second = -1


func stop() -> void:
	visible = false
	timer.stop()


func _on_timer_timeout() -> void:
	SfxManager.play(bang_sfx)
	visible = false
	timeout.emit()

extends CenterContainer


signal timeout


@onready var delay_label := $DelayLabel as Label
@onready var timer := $DelayLabel/Timer as Timer


func _process(_delta: float) -> void:
	if timer.is_stopped(): return
	delay_label.text = str(ceili(timer.time_left))


func start(time_sec: float) -> void:
	visible = true
	timer.start(time_sec)


func stop() -> void:
	visible = false
	timer.stop()


func _on_timer_timeout():
	visible = false
	timeout.emit()

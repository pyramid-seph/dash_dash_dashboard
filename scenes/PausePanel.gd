extends PanelContainer


const BLINK_DURATION_SEC: float = 0.75


@onready var pause_label := %PauseLabel as Label
@onready var timer := $Timer as Timer


func _on_visibility_changed():
	if not visible:
		timer.stop()
		return
	
	pause_label.visible = true
	timer.start(BLINK_DURATION_SEC)


func _on_timer_timeout():
	pause_label.visible = !pause_label.visible

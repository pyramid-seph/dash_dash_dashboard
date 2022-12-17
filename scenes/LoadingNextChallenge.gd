extends CenterContainer


signal timeout


@onready var timer_bar := %TimerBar
@onready var result_label := %ResultLabel as Label


func _build_error_message(challenge: RequestChallenge) -> String:
	var diff_curp_str: Array[String] = []
	var title: String = ""
	var diff_proof: Array[String]= challenge.get_life_proof_diff()
	var diff_curp: Array[String] = challenge.get_curp_query_diff()
	if not diff_proof.is_empty(): title += "Life proof image is different. "
	if diff_curp.is_empty(): 
		title += "No XCrash inconsistencies."
	else:
		title += "XCrash inconsistencies: "
	for diff in diff_curp:
		match diff:
			PersonDescriptor.DESCRIPTION_NAME:
				diff_curp_str.append("NAME")
			PersonDescriptor.DESCRIPTION_AGE:
				diff_curp_str.append("AGE")
			PersonDescriptor.DESCRIPTION_ADDRESS:
				diff_curp_str.append("ADDRESS")
			PersonDescriptor.DESCRIPTION_CURP:
				diff_curp_str.append("ID")
	return title + ", ".join(diff_curp_str)


func start(time_sec: float, is_correct: bool, challenge: RequestChallenge) -> void:
	if is_correct:
		result_label.text = "CORRECT!\n\nReady?..."
	else:
		result_label.text = "WRONG!\n\n%s\n\nReady?..." % _build_error_message(challenge)
		
	visible = true
	timer_bar.start(time_sec)


func stop() -> void:
	visible = false
	timer_bar.stop()


func _on_timer_bar_timeout() -> void:
	visible = false
	timeout.emit()

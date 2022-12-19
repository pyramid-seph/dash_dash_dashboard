extends Control

func _ready():
	if OS.get_name() == "Web":
		visible = false

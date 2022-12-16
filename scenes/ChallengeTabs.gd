extends TabContainer

func _ready():
	var children = get_children()
	for i in children.size():
		set_tab_title(i, children[i].title)

extends ProgressBar

func _ready():
	_update()

func _update():
	value =get_parent().get_parent().money
	

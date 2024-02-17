extends ProgressBar


func _ready():
	update()
	
	
func update():
	value = get_parent().get_parent().happiness
	
	

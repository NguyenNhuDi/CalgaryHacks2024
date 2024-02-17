extends Control

# Function to show the pop-up window
func show_popup():
	# Set the visibility of the Control node to true to show the pop-up
	self.visible = true

# Function to hide the pop-up window
func hide_popup():
	# Set the visibility of the Control node to false to hide the pop-up
	self.visible = false

func _on_exit_pressed():
	hide_popup()

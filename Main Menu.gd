func _on_play_pressed():
	var game_scene_path = "res://Main.tscn"
	get_tree().change_scene_to_file(game_scene_path)

# Called when the "Quit" button is pressed
func _on_exit_pressed():
	get_tree().quit()


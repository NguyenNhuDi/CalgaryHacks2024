extends Control



func _on_play_again_pressed():
	var game_scene_path = "res://Main.tscn"
	get_tree().change_scene_to_file(game_scene_path)	


func _on_quit_pressed():
	get_tree().quit()

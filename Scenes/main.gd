extends Node2D




func _on_quit_button_up():
	get_tree().quit()


func _on_new_game_button_up():
	get_tree().change_scene_to_file("res://Scenes/the_island.tscn")


func _on_credits_button_up():
	$Control/credits.show()

func _on_how_to_play_button_up():
	$"Control/how to play".show()


func _on_how_to_play_button_back_button_up():
	$"Control/how to play".hide()


func _on_credits_back_button_up():
	$Control/credits.hide()


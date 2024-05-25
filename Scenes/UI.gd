extends Control

@onready var wave_start_button=$wave_start
@onready var new_game_button=$new_game

signal wave_start
signal new_game


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignalBus.connect("player_death",player_death)
	new_game_button.hide()



func update_ui(data):
	print(data)


func player_death():
	new_game_button.show()



func show_wave_start_button():
	wave_start_button.show()


func _on_wave_start_button_up():
	wave_start.emit()
	wave_start_button.hide()


func _on_new_game_button_up():
	new_game.emit()
	new_game_button.hide()

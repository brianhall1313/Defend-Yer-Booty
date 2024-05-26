extends Control

@onready var wave_start_button=$wave_start
@onready var new_game_button=$new_game

@onready var player_experience_label=$PanelContainer/VBoxContainer/HBoxContainer/player_experience

@onready var firing_speed=$PanelContainer/VBoxContainer/firing_speed

signal wave_start
signal new_game


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignalBus.connect("player_death",player_death)
	new_game_button.hide()
	firing_speed.setup("Firing Speed")



func update_ui(player):
	player_experience_label.text=str(player.experience)
	firing_speed.update(player.upgrades["Firing Speed"],player.upgrade_cost["Firing Speed"],(player.upgrade_cost["Firing Speed"]>player.experience))


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

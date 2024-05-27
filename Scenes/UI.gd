extends Control

@onready var wave_start_button=$wave_start
@onready var new_game_button=$new_game

@onready var player_experience_label=$PanelContainer/VBoxContainer/HBoxContainer/player_experience

@onready var firing_speed=$PanelContainer/VBoxContainer/firing_speed
@onready var damage=$PanelContainer/VBoxContainer/damage
@onready var shot_speed=$PanelContainer/VBoxContainer/shot_speed

@onready var health_bar=$PanelContainer/VBoxContainer/VBoxContainer/health_bar
@onready var repair_button=$PanelContainer/VBoxContainer/VBoxContainer/repair_button

signal wave_start
signal new_game


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignalBus.connect("player_death",player_death)
	new_game_button.hide()
	firing_speed.setup("Firing Speed")
	damage.setup("Damage")
	shot_speed.setup("Shot Speed")



func update_ui(player):
	if Global.current_state=="setup" and int(player_experience_label.text)>10 and health_bar.value<health_bar.max_value:
		repair_button.disabled=false
	else:
		repair_button.disabled=true
	var initial:bool=true
	if initial:
		initial=false
		health_bar.max_value=player.max_health
		health_bar.value=player.max_health
	health_bar.value=player.current_health
	var list:Array[String]=["Firing Speed","Damage","Shot Speed"]
	player_experience_label.text=str(player.experience)
	for item in list:
		var num:int=player.upgrades[item]
		var upgrade:bool=player.upgrade_cost[num]>player.experience or Global.current_state=="dead"
		var cost:int
		if num==10:
			cost=0
		else:
			cost=player.upgrade_cost[num]
		if item=="Firing Speed":
			firing_speed.update(num,cost,upgrade)
		elif item=="Damage":
			damage.update(num,cost,upgrade)
		elif item=="Shot Speed":
			shot_speed.update(num,cost,upgrade)


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


func _on_repair_button_button_up():
	GlobalSignalBus.repair.emit()


func _on_quit_button_up():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

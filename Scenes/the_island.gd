extends Node2D

@onready var map=$map
@onready var spawn=$pirate_spawn_path/pirate_spawn_point
@onready var target=$landing_zone/CollisionShape2D/target
@onready var enemies=$enemies
@onready var ui=$UI
@onready var new_player:PackedScene=preload("res://Scenes/player.tscn")
@onready var shot:PackedScene=preload("res://Scenes/ball.tscn")
@onready var ship:PackedScene=preload("res://Scenes/ship.tscn")
@onready var dingy:PackedScene=preload("res://Scenes/dingy.tscn")


var player
var center:Vector2i = Vector2i(24,8)
var player_position:Vector2
var level=1
var check:bool=false


# Called when the node enters the scene tree for the first time.
func _ready():
	connect_to_global_signal_bus()
	player_position=map.map_to_local(center)
	spawn_player()
	Global.change_state("setup")
	ui.show_wave_start_button()

func _process(_delta):
	if check:
		check_win()
		check=false


func connect_to_global_signal_bus():
	GlobalSignalBus.connect("shots_fired",spawn_bullet)
	GlobalSignalBus.connect("spawn_dingy",spawn_dingy)
	GlobalSignalBus.connect("boat_died",check_trigger)
	GlobalSignalBus.connect("player_death",player_death)


func setup_level():
	for _i in range(level):
		spawn_pirate_ship()



func spawn_bullet(new_position:Vector2,new_rotation:float):
	var new = shot.instantiate()
	new.shoot(new_position,new_rotation)
	add_child(new)


func spawn_player():
	player = new_player.instantiate()
	add_child(player)
	player.position = player_position


func spawn_pirate_ship():
	spawn.progress_ratio=randf()
	var new = ship.instantiate()
	new.position = spawn.position
	enemies.add_child(new)
	new.target_acquired(target.global_position)


func spawn_dingy(pirate):
	var new = dingy.instantiate()
	new.position = pirate.get_dingy_spawn()
	enemies.add_child(new)
	new.target_acquired(target.global_position) 


func check_win():
	if len(enemies.get_children())==0:
		print("player wins")
		level+=1
		ui.show_wave_start_button()
		Global.change_state("setup")
		

func check_trigger(_experience):
	if check==false:
		check=true

func new_game():
	get_tree().reload_current_scene()


func next_level():
	setup_level()


func _on_ui_wave_start():
	Global.change_state("play")
	next_level()
	


func _on_landing_zone_area_entered(area):
	player.take_damage(area.get_parent().damage)
	area.get_parent().speed=0


func _on_ui_new_game():
	new_game()
	Global.global_speed=1


func player_death():
	Global.change_state("dead")
	Global.global_speed=0

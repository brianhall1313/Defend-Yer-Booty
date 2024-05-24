extends Node2D

@onready var map=$map
@onready var spawn=$pirate_spawn_path/pirate_spawn_point
@onready var target=$landing_zone/CollisionShape2D/target
@onready var new_player:PackedScene=preload("res://Scenes/player.tscn")
@onready var shot:PackedScene=preload("res://Scenes/ball.tscn")
@onready var ship:PackedScene=preload("res://Scenes/ship.tscn")
@onready var dingy:PackedScene=preload("res://Scenes/dingy.tscn")

var player
var center:Vector2i = Vector2i(24,8)
var player_position:Vector2


# Called when the node enters the scene tree for the first time.
func _ready():
	connect_to_global_signal_bus()
	player_position=map.map_to_local(center)
	spawn_player()
	spawn_pirate_ship()


func connect_to_global_signal_bus():
	GlobalSignalBus.connect("shots_fired",spawn_bullet)


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
	add_child(new)
	new.target_acquired(target.global_position)

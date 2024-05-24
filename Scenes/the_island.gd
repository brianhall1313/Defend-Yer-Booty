extends Node2D

@onready var map=$map
@onready var new_player:PackedScene=preload("res://Scenes/player.tscn")
var player
var center:Vector2i = Vector2i(9,8)
var player_position:Vector2


# Called when the node enters the scene tree for the first time.
func _ready():
	player_position=map.map_to_local(center)
	spawn_player()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_player():
	player = new_player.instantiate()
	add_child(player)
	player.position = player_position

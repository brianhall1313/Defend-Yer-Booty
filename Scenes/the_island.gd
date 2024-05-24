extends Node2D

@onready var map=$map
var center:Vector2i = Vector2i(15,8)
var player_position:Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	player_position=map.map_to_local(center)
	spawn_player()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_player():
	pass

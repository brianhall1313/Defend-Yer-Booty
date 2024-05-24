extends Node2D

@onready var barrel = $barrel_tip

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.look_at(get_global_mouse_position())

func _unhandled_input(event):
	if event is InputEventKey:
		if event.is_action_released("shoot"):
			shoot()

func shoot():
	GlobalSignalBus.shots_fired.emit(barrel.global_position,self.global_rotation)

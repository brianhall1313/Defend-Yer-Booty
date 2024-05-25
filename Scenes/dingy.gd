extends Node2D

var target:Vector2
var max_health:int=1
var current_health:int
var damage:int=1
var experience_reward:int=1
@export var speed:int=100
var direction:Vector2=Vector2.RIGHT
# Called when the node enters the scene tree for the first time.
func _ready():
	current_health = max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += speed*delta*direction*Global.global_speed


func target_acquired(new_target:Vector2):
	target = new_target
	look_at(target)
	direction=direction.rotated(get_rotation())


func explode():
	self.queue_free()


func get_hit(damage_taken:int):
	current_health -=damage_taken
	if current_health <= 0:
		GlobalSignalBus.boat_died.emit(experience_reward) 
		explode()

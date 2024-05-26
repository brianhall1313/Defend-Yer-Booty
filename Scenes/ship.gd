class_name Ship
extends Node2D

@onready var timer=$dingy_timer
var max_health:int=10
var current_health:int
var damage:int=10
var target:Vector2
var experience_reward:int=10
var spawn_time_min:float=4.0
var spawn_time_max:float=6.0
@export var speed:int=5
var direction:Vector2=Vector2.RIGHT

# Called when the node enters the scene tree for the first time.
func _ready():
	current_health = max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position+=speed*delta*direction*Global.global_speed

func get_dingy_spawn():
	return $dingy_spawn.global_position
	
	
func target_acquired(new_target:Vector2):
	target = new_target
	look_at(target)
	direction=direction.rotated(get_rotation())
	timer.wait_time=spawn_time_min
	timer.start()
	


func get_hit(damage_taken:int):
	current_health -=damage_taken
	if current_health <= 0:
		GlobalSignalBus.boat_died.emit(experience_reward) 
		explode()


func explode():
	self.queue_free()

func _on_dingy_timer_timeout():
	if Global.current_state=="play":
		GlobalSignalBus.spawn_dingy.emit(self)
		timer.wait_time=randf_range(spawn_time_min,spawn_time_max)

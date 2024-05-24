extends Node2D

var max_health:int=10
var current_health:int
var target:Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	current_health = max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func target_acquired(new_target:Vector2):
	target = new_target
	look_at(target)


func get_hit():
	current_health -=1
	if current_health <= 0:
		explode()


func explode():
	self.queue_free()


func _on_area_2d_area_entered(area):
	get_hit()

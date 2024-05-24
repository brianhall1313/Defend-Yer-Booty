extends Node2D

@export var speed:int=700
var direction:Vector2=Vector2.RIGHT
# Called when the node enters the scene tree for the first time.
func _ready():
	direction=direction.rotated(get_rotation())


func _process(delta):
	position += speed*delta*direction


func shoot(new_position:Vector2,new_rotation:float):
	self.position=new_position
	self.global_rotation=new_rotation


func _on_visible_on_screen_notifier_2d_screen_exited():
	self.queue_free()


func _on_area_2d_area_entered(area):
	print("hit")
	self.queue_free()

class_name Ball
extends Node2D

const base_damage:int=1
const base_speed:int=500
@export var damage:int=base_damage
@export var speed:int=base_speed
@onready var sprite=$Sprite2D
var direction:Vector2=Vector2.RIGHT
# Called when the node enters the scene tree for the first time.
func _ready():
	direction=direction.rotated(get_rotation())


func _process(delta):
	position += speed*delta*direction*Global.global_speed


func shoot(new_position:Vector2,new_rotation:float,upgrades):
	self.position=new_position
	self.global_rotation=new_rotation
	self.damage=base_damage+upgrades["Damage"]
	self.speed=base_speed+((upgrades["Shot Speed"]*.1)*base_speed)


func _on_visible_on_screen_notifier_2d_screen_exited():
	self.queue_free()


func _on_area_2d_area_entered(area):
	if area.get_parent().has_method("get_hit"):
		area.get_parent().get_hit(damage)
		var new=Global.animations["hit"].instantiate()
		new.position=self.position
		get_tree().get_current_scene().add_child(new)
		new.play_animation()
		GlobalSignalBus.play_effect.emit("hit")
		self.queue_free()

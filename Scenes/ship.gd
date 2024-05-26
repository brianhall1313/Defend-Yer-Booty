class_name Ship
extends Node2D

@onready var timer=$dingy_timer
@onready var sprite=$Sprite2D
@onready var health_bar= $health_bar
@onready var damage_timer=$damage_timer
@onready var colors:Dictionary={
	"basic":{
		"full":preload("res://Textures/ship (2).png"),
		"hurt":preload("res://Textures/ship (8).png"),
		"low":preload("res://Textures/ship (14).png"),
		"dead":preload("res://Textures/ship (20).png")
		},
	"red":{
		"full":preload("res://Textures/ship (3).png"),
		"hurt":preload("res://Textures/ship (9).png"),
		"low":preload("res://Textures/ship (15).png"),
		"dead":preload("res://Textures/ship (21).png")
	},
	"blue":{
		"full":preload("res://Textures/ship (5).png"),
		"hurt":preload("res://Textures/ship (11).png"),
		"low":preload("res://Textures/ship (17).png"),
		"dead":preload("res://Textures/ship (23).png")
	}
		}
var color:String="basic"
var max_health:int=30
var current_health:int
var damage:int=10
var target:Vector2
var experience_reward:int=10
var spawn_time_min:float=4.0
var spawn_time_max:float=6.0

@export var speed:int=10
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
	health_bar.value=current_health
	if current_health<10:
		sprite.texture=colors[color]["hurt"]
	if current_health<5:
		sprite.texture=colors[color]["low"]
	if current_health <= 0:
		GlobalSignalBus.boat_died.emit(experience_reward) 
		explode()


func explode():
	var new=Global.animations["explosion"].instantiate()
	new.position=self.position
	get_tree().get_current_scene().add_child(new)
	new.play()
	self.queue_free()


func setup(new_color:String):
	self.color=new_color
	self.sprite.texture=self.colors[color]["full"]
	if color == "red":
		max_health=20
		current_health = max_health
		speed=30
		health_bar.max_value=max_health
		health_bar.value=max_health
		return
	if color=="blue":
		max_health=40
		spawn_time_max-=1
		spawn_time_min-=1
		health_bar.max_value=max_health
		health_bar.value=max_health
		return
	health_bar.max_value=max_health
	health_bar.value=max_health

func get_random_color():
	return colors.keys().pick_random()


func _on_dingy_timer_timeout():
	if Global.current_state=="play":
		GlobalSignalBus.spawn_dingy.emit(self)
		timer.wait_time=randf_range(spawn_time_min,spawn_time_max)


func first_blood():
	damage_timer.start()

func _on_damage_timer_timeout():
	GlobalSignalBus.player_damage_dealt.emit(damage)

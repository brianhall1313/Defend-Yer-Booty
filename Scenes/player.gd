extends Node2D

@onready var shot_timer = $shot_timer
@onready var barrel = $barrel_tip
var experience:int=0
const shot_delay_base:float=3.0
var shot_delay:float=3.0
var shoot_ready:bool=true
var max_health:int=10
var current_health:int=1

var upgrades:Dictionary={"firing speed":0}



# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignalBus.connect("boat_died",gain_experience)
	current_health=max_health
	set_timer()
	shot_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.look_at(get_global_mouse_position())
	if Global.auto_shoot:
		shoot()


func set_timer():
	shot_timer.wait_time=shot_delay
	if Global.DEBUG:
		shot_timer.wait_time=.1



func _unhandled_input(event):
	if event is InputEventKey:
		if event.is_action_released("shoot"):
			shoot()

func shoot():
	if shoot_ready==true and (Global.current_state=="play" or Global.current_state=="setup"):
		GlobalSignalBus.shots_fired.emit(barrel.global_position,self.global_rotation,upgrades)
		shoot_ready=false
		shot_timer.start()


func gain_experience(xp):
	experience+=xp
	print(experience)


func take_damage(damage:int):
	if damage<current_health:
		current_health-=damage
	else:
		current_health=0
		GlobalSignalBus.player_death.emit()
		print('player dead')
	


func upgrade_request(upgrade_name,cost):
	if upgrades.has(upgrade_name):
		upgrades[upgrade_name]+=1
		experience-=cost
		if upgrade_name=="firing speed":
			shot_delay = shot_delay_base-(upgrades[upgrade_name]*.25)


func _on_shot_timer_timeout():
	shoot_ready=true

extends Node

@onready var animations:Dictionary={
	"explosion":preload("res://Animations/explosion.tscn")
	}


const DEBUG=false
var auto_shoot=true

const STATES:Array[String]=["menu","play","setup","dead"]

var current_state:String=""
var global_speed:float=1

func _ready():
	current_state="menu"


func change_state(new_state):
	if new_state in STATES:
		current_state=new_state

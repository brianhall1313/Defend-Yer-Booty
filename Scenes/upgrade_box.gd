extends HBoxContainer

@onready var upgrade_bar=$VBoxContainer/upgrade_bar
@onready var upgrade_cost=$VBoxContainer2/VBoxContainer/upgrade_cost
@onready var upgrade_button=$VBoxContainer2/upgrade_button
@onready var name_label=$VBoxContainer/name_label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func setup(new_text:String):
	name_label.text=new_text
	upgrade_cost.text=str(1)

func update(new_level:int,new_cost,disable=false):
	update_bar(new_level)
	upgrade_cost.text=str(new_cost)
	if disable or new_level>=10:
		upgrade_button.disabled=true


func update_bar(new_level):
	var i:int=1
	for child in upgrade_bar.get_children():
		if i<=new_level:
			child.color=Color('Green')
			i+=1
		else:
			return


func _on_upgrade_button_button_up():
	GlobalSignalBus.upgrade.emit(name_label.text,int(upgrade_cost.text))

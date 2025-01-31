extends Node

signal spawn_dingy(pirate)
signal shots_fired(barrel_position:Vector2,player_rotation:float,upgrades)
signal boat_died(reward:int)
signal player_death
signal upgrade(upgrade_name,cost)
signal ui_update
signal repair
signal player_damage_dealt(new_damage)
signal play_effect(effect:String)

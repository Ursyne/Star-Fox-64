extends Node2D


func _physics_process(delta):
	$Panel/RingsTotal.text = str(Global.rings)
	if Input.is_action_just_released("ui_select"):
		_on_Button_pressed()

func _on_Button_pressed():
	$AudioStreamPlayer.playing = true
	yield(get_tree().create_timer(.5),"timeout")
	get_tree().change_scene("res://Main.tscn")

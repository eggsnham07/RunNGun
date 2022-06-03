extends Control

func _physics_process(_delta):
	$Layer/Titles/FPS.text = String(Performance.get_monitor(Performance.TIME_FPS))

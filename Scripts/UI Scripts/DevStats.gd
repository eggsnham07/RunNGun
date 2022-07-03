extends Control

func _physics_process(_delta):
	$Layer/Titles/FPS.text = String(Performance.get_monitor(Performance.TIME_FPS))
	if Global.debug_mode:
		$Layer/Titles/Mode.text = "Debug"
	else:
		$Layer/Titles/Mode.text = "Release"

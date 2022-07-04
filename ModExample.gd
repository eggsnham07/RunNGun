extends Mod

func _ready():
	self.set_name("Custom Mod")
	self.set_version(0.6)

func main(data):
	log_to_console("Mod: " + self.get_name())
	log_to_console("Loader: " + String(self.get_version()))

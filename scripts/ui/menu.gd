extends Control

@onready var settings_panel = $Menu2
@onready var settings_button = $Menu/VBoxContainer/SettingsButton

func _ready():
	# Conecta os sinais dos botões
	$Menu/VBoxContainer/StartButton.pressed.connect(_on_start_button_pressed)
	$Menu/VBoxContainer/QuitButton.pressed.connect(_on_quit_button_pressed)
	if settings_button:
		settings_button.pressed.connect(_on_settings_button_pressed)
		
func _on_settings_button_pressed():
	if settings_panel:
		settings_panel.visible = true
		if settings_panel.has_method("update_ui_state"):
			settings_panel.update_ui_state()

func _on_start_button_pressed():
	GameManager.start_game()

func _on_quit_button_pressed():
	get_tree().quit()

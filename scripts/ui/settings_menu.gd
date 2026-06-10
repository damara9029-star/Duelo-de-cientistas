extends Control

@onready var resolution_option_button = $ResolutionOptionButton
@onready var fullscreen_check_box = $FullscreenCheckBox
@onready var close_button = $CloseButton

const RESOLUTIONS = [
	Vector2i(1920, 1080),
	Vector2i(1600, 900),
	Vector2i(1366, 768),
	Vector2i(1280, 720)
]

func _ready():
	add_resolutions()
	resolution_option_button.item_selected.connect(_on_resolution_selected)
	fullscreen_check_box.toggled.connect(_on_fullscreen_toggled)
	close_button.pressed.connect(_on_close_button_pressed)
	update_ui_state()

func add_resolutions():
	resolution_option_button.clear()
	for res in RESOLUTIONS:
		var label = str(res.x) + " x " + str(res.y)
		resolution_option_button.add_item(label)

func update_ui_state():
	# Verifica se está em Fullscreen para marcar a caixa
	var current_mode = DisplayServer.window_get_mode()
	var is_fullscreen = current_mode == DisplayServer.WINDOW_MODE_FULLSCREEN or current_mode == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN
	fullscreen_check_box.set_pressed_no_signal(is_fullscreen)
	
	# Tenta encontrar a resolução atual na lista para selecionar
	var current_size = get_window().size
	var index = -1
	for i in range(RESOLUTIONS.size()):
		if RESOLUTIONS[i] == current_size:
			index = i
			break
	
	if index != -1:
		resolution_option_button.selected = index

func _on_fullscreen_toggled(toggled_on: bool):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		resolution_option_button.disabled = true # Desabilita resolução em fullscreen
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		resolution_option_button.disabled = false
		# Restaura o tamanho da janela para a seleção atual
		_on_resolution_selected(resolution_option_button.selected)
		center_window()

func _on_resolution_selected(index: int):
	if index >= 0 and index < RESOLUTIONS.size():
		var size = RESOLUTIONS[index]
		get_window().size = size
		center_window()

func center_window():
	# Centraliza a janela no monitor atual
	var screen_center = DisplayServer.screen_get_position() + DisplayServer.screen_get_size() / 2
	var window_size = get_window().size
	get_window().position = screen_center - (window_size / 2)

func _on_close_button_pressed():
	visible = false

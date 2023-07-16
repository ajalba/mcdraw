extends Node2D
var rng = RandomNumberGenerator.new()
var cs_script = load("res://monte_carlo.cs")
var cs_callable = cs_script.new()
var usable_points = Array()
var viewport_texture
var viewport_image
var sum
var pixel
var point
var can_mix_contrast = false
var can_mix_edges = false
var top_umbral = 1.0
var umbral_diff = 0.003
var bot_umbral = 0.999
var found = false
var random_number = 1
var point_index = 0
var recalculate_usable_points = false
var showed_buttons = false
var use_point = Vector3(0.0,0.0,0.0)
# Called when the node enters the scene tree for the first time.
func _ready():
	await RenderingServer.frame_post_draw

	$Board.texture = $SubViewportBoardContainer/SubViewport.get_texture()
	$Board.material.set("shader_parameter/img_texture", $SubViewportContrastContainer/SubViewport.get_texture())
	Global.board_expand_original = $SubViewportBoardContainer/SubViewport.get_texture().get_image()
	Global.board_expand = ImageTexture.create_from_image($SubViewportBoardContainer/SubViewport.get_texture().get_image())
	viewport_texture = $SubViewportMaskContainer/SubViewport.get_texture()
	Global.mask_image = ImageTexture.create_from_image(viewport_texture.get_image())
	Global.mask_image_original = viewport_texture.get_image()
	$Board.position.x = 200 + viewport_texture.get_width() / 4
	$Board.position.y = viewport_texture.get_height() / 2

func reset_usable_points():
	usable_points = Array()
	viewport_texture = $SubViewportMaskContainer/SubViewport.get_texture()
	viewport_image = viewport_texture.get_image()
	sum = float(0.0)
	for j in range(rng.randi_range(0, 1), viewport_image.get_height(), 2):
		for i in range(rng.randi_range(0, 1), viewport_image.get_width(), 2):
			pixel = float(viewport_image.get_pixel(i,j).r)
			if pixel > bot_umbral and pixel < top_umbral:
				sum += pixel
				usable_points.append(Vector3( pixel, i, j))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	await RenderingServer.frame_post_draw
	if not Global.mode_write:
		Global.mask_image.update($SubViewportMaskContainer/SubViewport.get_texture().get_image())
		Global.board_expand.update($SubViewportBoardContainer/SubViewport.get_texture().get_image())
	if Global.refresh_mask_original:
		Global.board_expand.update(Global.board_expand_original)
		Global.board_expand_to_clean = Global.board_expand_original
		Global.refresh_mask_original = false
#	random_number = rng.randi_range(1, 2)
	if Global.drawing_style == Global.DRAWING_TYPE.AUTOMATIC:
		Global.point_frame = rng.randi_range(0, 39)
		reset_usable_points()
		use_point = Vector3(0.0,0.0,0.0)
		usable_points.sort_custom(func(a,b): return a>b)
		random_number = rng.randf() * sum
		for point in usable_points:
			if random_number-point[0] < 0:
				use_point = point
				break
			else:
				random_number -= point[0]
		if use_point[1] != 0.0:
			Global.point_frame = rng.randi_range(0, 39)
			Global.point_position = Vector2i(use_point[1], use_point[2])
		else:
			bot_umbral -= umbral_diff
		if not Global.mask_original_made:
			Global.board_expand_original = $SubViewportBoardContainer/SubViewport.get_texture().get_image()
			Global.mask_image_original = $SubViewportMaskContainer/SubViewport.get_texture().get_image()
			Global.mask_original_made = true
	elif Global.drawing_style == Global.DRAWING_TYPE.EDGES_MASK:
		$Board.material.set(
			"shader_parameter/img_texture", ImageTexture.create_from_image(Global.base_image_for_edges_drawn)
		)
	
	if Global.drawing_style != Global.DRAWING_TYPE.DELETE and not showed_buttons:
		$Button.show()
		$CheckButtonContrast.show()
		$CheckButtonEdges.show()
		$CheckButtonAuto.show()
		$RichTextLabel.show()
		$RichTextLabelAUTOMATIC.show()
		$LabelContrast.show()
		showed_buttons = true
		if not Global.mask_original_made:
			Global.board_expand_original = $SubViewportBoardContainer/SubViewport.get_texture().get_image()
			Global.mask_image_original = $SubViewportMaskContainer/SubViewport.get_texture().get_image()
	
func _on_check_button_toggled(button_pressed):
	if button_pressed:
		Global.drawing_style = Global.DRAWING_TYPE.CONTRAST_MASK		
		can_mix_edges = false
		$Board.material.set("shader_parameter/img_texture", $SubViewportContrastContainer/SubViewport.get_texture())
	can_mix_contrast = button_pressed
	$Board.material.set("shader_parameter/can_mix", button_pressed)
	if !button_pressed:
		Global.refresh_mask = true		
		Global.drawing_style = Global.DRAWING_TYPE.BOTH_MASK

func _on_check_button_edges_toggled(button_pressed):
	if button_pressed:
		can_mix_contrast = false
		Global.base_image_for_edges_drawn = $SubViewportEdgesContainer2/SubViewport.get_texture().get_image()
		Global.original_base_image_for_edges_drawn = $SubViewportEdgesContainer2/SubViewport.get_texture().get_image()		
		$Board.material.set("shader_parameter/img_texture", ImageTexture.create_from_image(Global.base_image_for_edges_drawn))
		Global.drawing_style = Global.DRAWING_TYPE.EDGES_MASK
		$RichTextLabelDeleteEdges.show()		
		$CheckBoxDeleteEdges.show()
	can_mix_edges = button_pressed
	$Board.material.set("shader_parameter/can_mix", button_pressed)
	if !button_pressed:
		$CheckBoxDeleteEdges.hide()
		$RichTextLabelDeleteEdges.hide()
		Global.refresh_edges_mask = true
		Global.drawing_style = Global.DRAWING_TYPE.BOTH_MASK
		
		

func _input(event):
	if event.is_action_pressed("toggle_mask"):
		$SubViewportMaskContainer.visible = !$SubViewportMaskContainer.visible


func _on_check_box_toggled(button_pressed):
	if button_pressed:
		Global.drawing_style = Global.DRAWING_TYPE.AUTOMATIC
		bot_umbral = 0.999
	if not button_pressed:
		Global.board_expand_to_clean = $SubViewportBoardContainer/SubViewport.get_texture().get_image()
		Global.mask_to_clean = $SubViewportMaskContainer/SubViewport.get_texture().get_image()
		Global.drawing_style = Global.DRAWING_TYPE.BOTH_MASK
		Global.point_position = Vector2i(1000, 10000)

	can_mix_contrast = false
	can_mix_edges = false
	


func _on_check_box_delete_edges_toggled(button_pressed):
	Global.delete_edges_in_draw = button_pressed


func _on_button_save_pressed():
	$FileDialogSaveImage.popup()


func _on_button_gui_pressed():
	Global.animation_played = false
	Global.play_animation = true


func _on_file_dialog_save_image_file_selected(path):
	Global.board_expand_to_clean.save_jpg(path)


func _on_check_button_auto_toggled(button_pressed):
	if button_pressed:
		Global.drawing_style = Global.DRAWING_TYPE.AUTOMATIC
		bot_umbral = 0.999
	if not button_pressed:
		Global.board_expand_to_clean = $SubViewportBoardContainer/SubViewport.get_texture().get_image()
		Global.mask_to_clean = $SubViewportMaskContainer/SubViewport.get_texture().get_image()
		Global.drawing_style = Global.DRAWING_TYPE.BOTH_MASK
		Global.point_position = Vector2i(1000, 10000)

	can_mix_contrast = false
	can_mix_edges = false

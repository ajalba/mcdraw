extends Node2D

var format_string = "Point Size: %s"
# Called when the node enters the scene tree for the first time.
func _ready():
	$RichTextLabel.text = format_string % Global.point_size
	$HScrollBar.value = Global.point_size
#	$BaseImage.texture = ImageTexture.create_from_image(Global.base_image)
	$ColorPicker.color = Global.color


func _on_button_board_pressed():
	$FileDialog.popup()


func _on_file_dialog_file_selected(path):
	Global.board_image.load(path)


func _on_button_base_pressed():
	$FileDialogBaseImage.popup()


func _on_file_dialog_base_image_file_selected(path):
	Global.base_image.load(path)
	$BaseImage.texture = ImageTexture.create_from_image(Global.base_image)
	Global.load_base_image = true
	Global.refresh_mask = true
	Global.refresh_mask_original = true
	Global.drawing_style = Global.DRAWING_TYPE.BOTH_MASK


func _on_h_scroll_bar_value_changed(value):
	$RichTextLabel.text = format_string % value
	Global.point_size = value


func _on_color_picker_color_changed(color):
	Global.color = color
	Global.color_changed = true


func _on_button_pressed():
	Global.animation_played = false
	Global.play_animation_backwards = true

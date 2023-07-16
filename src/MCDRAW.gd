extends Node2D
var base_window_size = Vector2(
		ProjectSettings.get_setting("display/window/size/viewport_width"),
		ProjectSettings.get_setting("display/window/size/viewport_height")
)
var anim_position_1 = Vector2(0,0)
var anim_position_2 = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	get_viewport().connect("size_changed", _on_viewport_resize)

func _on_viewport_resize():
	$Principal.scale.x = DisplayServer.window_get_size().x/base_window_size.x
	$Principal.scale.y = DisplayServer.window_get_size().y/base_window_size.y
	$GUI.scale.x = DisplayServer.window_get_size().x/base_window_size.x
	$GUI.scale.y = DisplayServer.window_get_size().y/base_window_size.y
	$GUI.position.x = DisplayServer.window_get_size().x
	anim_position_1 = Vector2(DisplayServer.window_get_size().x, 0)
	anim_position_2 = Vector2(-DisplayServer.window_get_size().x, 0)
	$DisplayGui.get_animation("DisplayGui").track_set_key_value(1,0, anim_position_1)
	$DisplayGui.get_animation("DisplayGui").track_set_key_value(0,2,anim_position_2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.play_animation and not Global.animation_played:
		$DisplayGui.play("DisplayGui")
		Global.animation_played = true
		Global.play_animation = false
	if Global.play_animation_backwards and not Global.animation_played:
		$DisplayGui.play_backwards("DisplayGui")
		Global.animation_played = true
		Global.play_animation_backwards = false
		

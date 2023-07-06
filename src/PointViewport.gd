extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
#	$Point.texture = ImageTexture.create_from_image(Global.base_image)
	var window_size = DisplayServer.window_get_size()
	var sprite_size = $Point.texture.get_size()
	var scale_sprite = Vector2((window_size.x / sprite_size.x)*10, (window_size.y / sprite_size.y)*4)
	$Camera2D.set_zoom(scale_sprite)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Point.frame = Global.point_frame

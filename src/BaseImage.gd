extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.load_base_image:
		$Sprite2D.texture = ImageTexture.create_from_image(Global.base_image)
		var window_size = DisplayServer.window_get_size()
		var sprite_size = $Sprite2D.texture.get_size()
		var scale_sprite = Vector2(window_size.x / sprite_size.x, window_size.y / sprite_size.y)
		$Camera2D.set_zoom(scale_sprite)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.load_base_image:
		$Sprite2D.texture = ImageTexture.create_from_image(Global.base_image)
		var window_size = DisplayServer.window_get_size()
		var sprite_size = $Sprite2D.texture.get_size()
		var scale_sprite = Vector2(window_size.x / sprite_size.x, window_size.y / sprite_size.y)
		$Camera2D.set_zoom(scale_sprite)

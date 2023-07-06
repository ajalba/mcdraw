extends Node2D


# Called when the node enters the scene tree for the first time.
#func _ready():
#


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.load_base_image:
		$TextureRect.size = Vector2(1600,900)
		$TextureRect.texture = ImageTexture.create_from_image(Global.base_image)
	if not Global.base_image_for_contrast.is_empty() and Global.drawing_style == Global.DRAWING_TYPE.CONTRAST_MASK:
		$TextureRect.texture = ImageTexture.create_from_image(Global.base_image_for_contrast)
#		$SubViewportPoint.position = Global.point_position

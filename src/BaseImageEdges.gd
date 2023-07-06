extends Node2D

var original_image_taken = false
# Called when the node enters the scene tree for the first time.


func _process(_delta):
	if Global.load_base_image:
		$TextureRect.size = Vector2(1600,900)
		$TextureRect.texture = ImageTexture.create_from_image(Global.base_image)
#		Global.load_base_image = false
	if not Global.base_image_for_edges.is_empty() and Global.drawing_style == Global.DRAWING_TYPE.EDGES_MASK:
		$TextureRect.texture = ImageTexture.create_from_image(Global.base_image_for_edges)

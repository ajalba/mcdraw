extends Node2D

var point_size = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	await RenderingServer.frame_post_draw
	$TextureRect.size = Vector2(1600,900)
	$TextureRect.texture = $SubViewportContainer/SubViewport.get_texture()
	$PointSprite.texture = $SubViewportPoint/SubViewport.get_texture()
	$PointSprite.position = Global.point_position
	$PointSprite.material.set("shader_parameter/board_texture", $TextureRect.texture)
	$PointSprite.scale = Vector2(0.010, 0.010)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.refresh_mask:
		$PointSprite.position = Vector2(-10,0)
	await RenderingServer.frame_post_draw
	if Global.board_expand_original.is_empty():
		Global.board_expand_original = $SubViewportContainer/SubViewport.get_texture().get_image()
	if Global.color_changed:
		$PointSprite.material.set("shader_parameter/point_color", Global.color)
		Global.color_changed = false
	if Global.drawing_style == Global.DRAWING_TYPE.AUTOMATIC or Global.mode_write:
		$PointSprite.material.set("shader_parameter/board_texture", $TextureRect.texture)
		$TextureRect.texture = Global.board_expand
		$PointSprite.position = Global.point_position
	if Global.black_color_image.is_empty():
		Global.black_color_image = $SubViewportContainer/SubViewport.get_texture().get_image()
		$SubViewportContainer.queue_free()
	if point_size != Global.point_size:
		point_size = Global.point_size
		$PointSprite.scale = Vector2(0.005 + 0.002 * point_size, 0.005 + 0.002 * point_size)


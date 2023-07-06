extends Node2D
var viewport_texture
# Called when the node enters the scene tree for the first time.
func _ready():
	await RenderingServer.frame_post_draw
	var viewport_texture = $SubViewportContainer/SubViewport.get_texture()
	$TextureRect.size = Vector2(1600,900)
	$TextureRect.texture = viewport_texture
	Global.base_image_for_edges = viewport_texture.get_image()
	Global.original_base_image_for_edges = viewport_texture.get_image()

func _process(_delta):
	if Global.black_color_image.is_empty():
		Global.black_color_image = $SubViewportContainerColor/SubViewport.get_texture().get_image()
		$SubViewportContainerColor.queue_free()
	if Global.drawing_style == Global.DRAWING_TYPE.EDGES_MASK and not Global.mode_write:
		Global.base_image_for_edges = $SubViewportContainer/SubViewport.get_texture().get_image()
	if Global.mode_write:
		$TextureRect.texture = $SubViewportContainer/SubViewport.get_texture()
	if Global.refresh_mask:
		viewport_texture = $SubViewportContainer/SubViewport.get_texture()
		Global.base_image_for_contrast = viewport_texture.get_image()
		Global.original_base_image_for_contrast = viewport_texture.get_image()
#	if Global.drawing_style == Global.DRAWING_TYPE.EDGES_MASK and not Global.mode_write:
#		Global.base_image_for_edges = $SubViewportContainer/SubViewport.get_texture().get_image()
#	if Global.mode_write:
#		$TextureRect.texture = $SubViewportContainer/SubViewport.get_texture()

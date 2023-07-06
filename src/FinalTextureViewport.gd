extends Node2D
var point_size = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	await RenderingServer.frame_post_draw
	var viewport_texture = $SubViewportContainer/SubViewport.get_texture()
	$Mask.texture = viewport_texture
	Global.mask_image = ImageTexture.create_from_image(viewport_texture.get_image())
#	Global.mask_image = viewport_texture.get_image()
	$Point.material.set("shader_parameter/board_texture", viewport_texture)		
#	$Mask.texture = ImageTexture.create_from_image(Global.mask_image)
	point_size = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	await RenderingServer.frame_post_draw
	
	$Point.texture = $SubViewportPoint/SubViewport.get_texture()
	$Point.position = Global.point_position
#	if not Global.mask_image.is_empty() and Global.drawing_style == Global.DRAWING_TYPE.AUTOMATIC:
	$Mask.texture = Global.mask_image
	if Global.refresh_mask:
		var viewport_texture = $SubViewportContainer/SubViewport.get_texture()
		$Mask.texture = viewport_texture
		Global.mask_image.update(viewport_texture.get_image())
		Global.mask_image_original = viewport_texture.get_image()
		Global.mask_to_clean = viewport_texture.get_image()
		Global.refresh_mask = false
	if Global.mode_write:
		$Mask.texture = Global.mask_image
	if point_size != Global.point_size:
		point_size = Global.point_size
		$Point.scale = Vector2(0.010 + 0.001 * point_size, 0.010 + 0.001 * point_size)


extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.texture = $ContrastViewport/SubViewport.get_texture()
	$Sprite2D.material.set("shader_parameter/contrast_texture", $ContrastViewport/SubViewport.get_texture())
	$Sprite2D.material.set("shader_parameter/edges_texture", $EdgesViewport/SubViewport.get_texture())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	await RenderingServer.frame_post_draw	
	if Global.refresh_edges_mask:
		Global.refresh_edges_mask = false
		$Sprite2D.material.set("shader_parameter/edges_texture", ImageTexture.create_from_image(Global.base_image_for_edges_drawn))
		Global.refresh_mask = true

#	if Global.base_image_for_edges_drawn.is_empty():
#		Global.base_image_for_edges_drawn = $EdgesViewport/SubViewport.get_texture().get_image()
#		Global.original_base_image_for_edges_drawn = $EdgesViewport/SubViewport.get_texture().get_image()
#	$Sprite2D.texture = $ContrastViewport/SubViewport.get_texture()
#	$Sprite2D.material.set("shader_parameter/contrast_texture", $ContrastViewport/SubViewport.get_texture())
#	$Sprite2D.material.set("shader_parameter/edges_texture", $EdgesViewport/SubViewport.get_texture())
#	if Global.mode_write or Global.DRAWING_TYPE.CONTRAST_MASK:
#		Global.base_contrast_expand = $ContrastViewport/SubViewport.get_texture().get_image()
#	if Global.mode_write:
#		Global.base_edges_expand = $EdgesViewport/SubViewport.get_texture().get_image()

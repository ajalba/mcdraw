#extends Node2D
#
#
## Called when the node enters the scene tree for the first time.
#func _ready():
#	await RenderingServer.frame_post_draw
#	var viewport_texture = $SubViewportContainer/SubViewport.get_texture()
#	$TextureRect.size = Vector2(1600,900)
#	$TextureRect.texture = viewport_texture
#	$SafeSprite.texture = viewport_texture
#	Global.board_expand = $SubViewportContainer/SubViewport.get_texture().get_image()
#
#func _process(_delta):
#	$SubViewportPoint.position = Global.point_position
#	if not Global.board_expand.is_empty() and Global.drawing_style == Global.DRAWING_TYPE.AUTOMATIC:
#		$TextureRect.texture = ImageTexture.create_from_image(Global.board_expand)
#	if Global.mode_write:
#		$TextureRect.texture = ImageTexture.create_from_image(Global.board_expand)
##		$SafeSprite.frame = int((Global.point_position.x/19.2 + Global.point_position.y/10.8))
#		$SafeSprite.position = Global.original_texture_point_position
#		$SafeSprite.material.set("shader_parameter/x_coord", Global.original_texture_point_position.x)		
#		$SafeSprite.material.set("shader_parameter/y_coord", Global.original_texture_point_position.y)
##		$TextureRect.texture = ImageTexture.create_from_image(Global.board_expand)

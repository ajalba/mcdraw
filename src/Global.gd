extends Node

enum DRAWING_TYPE {BOTH_MASK, EDGES_MASK, CONTRAST_MASK, AUTOMATIC, DELETE}
var mode_write = false
var base_image = Image.new();
var contrast_image = Image.new();
var edges_image = Image.new();
var base_contrast_expand = Image.new()
var base_edges_expand = Image.new()

var mask_image = ImageTexture.new()
var mask_image_original = Image.new()
var mask_to_clean = Image.new()
var mask_original_made = false
var board_image = Image.new();
var board_expand = ImageTexture.new();
var board_expand_to_clean = Image.new()
var board_expand_original = Image.new();
var base_image_for_contrast = Image.new()
var original_base_image_for_contrast = Image.new()
var base_image_for_edges = Image.new()
var base_image_for_edges_drawn = Image.new()
var original_base_image_for_edges = Image.new()
var original_base_image_for_edges_drawn = Image.new()

var p_1 = Vector2(0,0)
var p_2 = Vector2(0,0)


var black_color_image = Image.new()
var white_color_image = Image.new()

var delete_edges_in_draw = false
var refresh_mask = true
var color_changed = false
var color = Color.BLACK
var point_size = 3
var drawing_style
var point_position
var original_texture_point_position
var point_frame = 1
var play_animation = false
var play_animation_backwards = false
var animation_played = false
var refresh_edges_mask = false

var refresh_mask_original = false
var load_base_image = false
var contrast_images_load = false
var edges_images_load = false
var mask_is_load = false
var aux_board_expand = Image.new()
# Called when the node enters the scene tree for the first time.
func _ready():
#	base_image.load("res://mugiwara.png" )
	board_image.load("res://blanco.png")
	drawing_style = DRAWING_TYPE.DELETE
	point_position = Vector2i(10000,10000)
	
func clear_area_edges(rect: Rect2):
	base_image_for_edges_drawn.blit_rect(original_base_image_for_edges_drawn, rect, Vector2i(rect.position))

func clear_area_edges_in_white(rect: Rect2):
	base_image_for_edges_drawn.blit_rect(board_expand_original, rect, Vector2i(rect.position))

func clear_area_contrast(rect: Rect2):
	base_image_for_contrast.blit_rect(original_base_image_for_contrast, rect, Vector2i(rect.position))
	
func clear_area_board(rect: Rect2):
	board_expand_to_clean.blit_rect(board_expand_original, rect, Vector2i(rect.position))
	mask_to_clean.blit_rect(mask_image_original, rect, Vector2i(rect.position))
	board_expand.update(board_expand_to_clean)
	mask_image.update(mask_to_clean)

func draw_black_in_edges(rect: Rect2):
	base_image_for_edges_drawn.blit_rect(black_color_image, rect, Vector2i(rect.position))

func select_rect_edges_image(rect: Rect2):
	base_image_for_edges_drawn.copy_from(board_expand_original)
	base_image_for_edges_drawn.blit_rect(original_base_image_for_edges_drawn, rect, Vector2i(rect.position))

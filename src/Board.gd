extends Sprite2D
var dragging = false
var local
var r_1 = Vector2i(0,0)
var r_2
var p1_posed = false
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _input(event):
	if not Global.drawing_style == Global.DRAWING_TYPE.AUTOMATIC:
		
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
			Global.mode_write = !Global.mode_write
		if Global.mode_write:
			Global.point_position = Vector2i(-10, -10)
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
			dragging = !dragging
			if not dragging and get_rect().has_point(to_local(event.position)):
				var l = to_local(event.position)
				r_2 = l
				var rect = Rect2(r_1.x + 800, r_1.y + 450, abs(r_1.x - r_2.x), abs(r_1.y - r_2.y))
				if Global.delete_edges_in_draw:
					Global.select_rect_edges_image(rect)
			if dragging and get_rect().has_point(to_local(event.position)):
				var l = to_local(event.position)			
	#			Global.p_1 = Vector2((l.x + 800)/1600, (l.y + 900)/450)
				r_1 = l
		if event is InputEventMouseMotion and dragging and get_rect().has_point(to_local(event.position)):
			if Global.drawing_style == Global.DRAWING_TYPE.EDGES_MASK:
				var l = to_local(event.position)
	#			Global.p_2 = Vector2((l.x + 800)/1600, (l.y + 900)/450)
				if not Global.delete_edges_in_draw:
					local = to_local(event.position)
					var rect = Rect2(local.x+800, local.y+450, 10, 10)
					Global.draw_black_in_edges(rect)
			else:
				local = to_local(event.position)
				Global.point_position = Vector2(local.x+800, local.y+450)

		if Global.mode_write and get_rect().has_point(to_local(event.position)):
			local = to_local(event.position)
			var rect = Rect2(local.x+800, local.y+450, 50, 50)
			if Global.drawing_style == Global.DRAWING_TYPE.EDGES_MASK:
				if not Global.delete_edges_in_draw:
					Global.clear_area_edges(rect)
				else:
					Global.clear_area_edges_in_white(rect)
			elif Global.drawing_style == Global.DRAWING_TYPE.CONTRAST_MASK:
				Global.clear_area_contrast(rect)
			elif Global.drawing_style == Global.DRAWING_TYPE.AUTOMATIC or Global.drawing_style == Global.DRAWING_TYPE.BOTH_MASK:
				Global.clear_area_board(rect) 

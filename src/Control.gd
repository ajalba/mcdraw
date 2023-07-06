extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _draw():
	draw_circle(Vector2(10,10), 50, Color.BLACK)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()

extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect.size = Vector2i(1600, 900)
	$ColorRect.color = Color.BLACK


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

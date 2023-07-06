extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.play_animation and not Global.animation_played:
		$DisplayGui.play("DisplayGui")
		Global.animation_played = true
		Global.play_animation = false
	if Global.play_animation_backwards and not Global.animation_played:
		$DisplayGui.play_backwards("DisplayGui")
		Global.animation_played = true
		Global.play_animation_backwards = false
		

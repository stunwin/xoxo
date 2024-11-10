extends Node2D

var placing: bool
signal placed(player:bool, row:int, col:int)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	placing = true
	if get_parent().player:
		%xsprite.visible = true
		%osprite.visible = false
	else:
		%xsprite.visible = false
		%osprite.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if placing:
		global_position = get_global_mouse_position()
		var touching = %boundingbox.get_overlapping_areas()
		if Input.is_action_just_pressed("leftclick") and touching.size() == 1:
			global_position = touching[0].global_position
			placing = false
			placed.emit(touching[0].row, touching[0].col)


func ai_process():
	pass

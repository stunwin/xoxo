extends Node2D

var turn:int = 0
var arr = [
[0, 0, 0],
[0, 0, 0],
[0, 0, 0],
]
var player:bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !player:
		ai_turn()
		return
	if Input.is_action_just_pressed("rightclick"):
		var new_x = preload("res://x.tscn").instantiate()
		new_x.placed.connect(self.on_placed)
		new_x.global_position = get_global_mouse_position()
		add_child(new_x)



func on_placed(row: int, col: int):
	var value:int 
	if player:
		value = 3
	else:
		value = 4
	arr[row][col] = value
	# print(arr)
	turn += 1
	if turn >= 3:
		check_winner(row, col)
	
	player = !player


func check_winner(row:int, col:int):
	var winvalue:int
	var rowtotal:int = 0
	var coltotal:int = 0
	var diagtotal:int = 0
	var reversediagtotal:int = 0

	if player:
		winvalue = 9
	else:
		winvalue = 12

	for i in range(3):
		rowtotal += arr[row][i]
		coltotal += arr[i][col]
	if col == row or col + row == 2:
		
		for i in range(3):
			diagtotal += arr[i][i]
			reversediagtotal += arr[2-i][i]
	
	if rowtotal == winvalue:
		print("row win!")
	elif coltotal == winvalue:
		print("col win!")
	elif diagtotal == winvalue:
		print("diag win!")
	elif reversediagtotal == winvalue:
		print("reverse diag win!")

func ai_turn():
	var new_x = preload("res://x.tscn").instantiate()
	new_x.placed.connect(self.on_placed)
	new_x.global_position = Vector2i(-200,-200)
	add_child(new_x)

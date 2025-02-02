extends Node

var card_data = [
	{"id": 1, "name":"0 blue", "card_sprite": preload("res://assets/cards/blue/0_blue.png")},
	{"id": 2, "name":"0 red", "card_sprite": preload("res://assets/cards/red/0_red.png")},
	{"id": 3, "name":"0 green", "card_sprite": preload("res://assets/cards/green/0_green.png")}
]
var card_deck = []

@export var card_scene: PackedScene
@export var card_holder: Node2D

#options
var board_col:int = 3
var board_row:int = 2
var board_col_start_pos:int = 100
var board_row_start_pos:int = 150

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for card in card_data:
		card_deck.append(card)
		card_deck.append(card)
	setup_boards()
	
func setup_boards():
	#define card placement
	var places = []
	var col = board_col_start_pos
	var row = board_row_start_pos
	for i in range(board_row):
		col = board_col_start_pos
		for j in range(board_col):
			places.append(Vector2(col,row))
			col += 200
		row += 300
	
	card_deck.shuffle()

	for i in range (card_deck.size()):
		var card = card_scene.instantiate()
		card.position = places[i]
		print(places[i])
		
		#setup card property
		card.card_id = card_deck[i].id
		card.card_name = card_deck[i].name
		card.sprite_front = card_deck[i].card_sprite
		
		#attach to holder as parent
		card_holder.add_child(card)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

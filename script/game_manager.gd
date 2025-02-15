extends Node

var card_data = [
	{"id": 1, "name":"mango", "card_sprite": preload("res://assets/cards/card1.png")},
	{"id": 2, "name":"pinneaple", "card_sprite": preload("res://assets/cards/card2.png")},
	{"id": 3, "name":"cherry", "card_sprite": preload("res://assets/cards/card3.png")},
	{"id": 4, "name":"coconut", "card_sprite": preload("res://assets/cards/card4.png")},
	{"id": 5, "name":"watermelon", "card_sprite": preload("res://assets/cards/card5.png")}
]
var card_deck = []

@export var card_scene: PackedScene
@export var card_holder: Node2D

#options
var board_col:int = 5
var board_row:int = 2
var board_col_start_pos:int = 100
var board_row_start_pos:int = 150

#states
var card_revealed = []
var able_to_click_card = true

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
		row += 270
	
	card_deck.shuffle()

	for i in range (card_deck.size()):
		var card = card_scene.instantiate()
		card.position = places[i]
		
		#setup card property
		card.card_id = card_deck[i].id
		card.card_name = card_deck[i].name
		card.sprite_front = card_deck[i].card_sprite
		
		#attach to holder as parent
		add_child(card)

func reveal_card_record(card: Node2D):
	card_revealed.append(card)
	check_match()

func check_match():
	if card_revealed.size() >= 2:
		able_to_click_card = false
		if(card_revealed[0].card_id == card_revealed[1].card_id):
			print("match")
			await get_tree().create_timer(1.0).timeout
			able_to_click_card = true
		else:
			print("not same, then reset")
			able_to_click_card = false
			await get_tree().create_timer(1.0).timeout
			for card in card_revealed:
				card.conceal_card()
			able_to_click_card = true
		card_revealed.clear()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

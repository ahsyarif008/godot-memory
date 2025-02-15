extends Node2D

#card component
@export var card_sprite: Sprite2D

#card props
var card_id: int
var card_name: String
var is_flipped: bool
var sprite_front: Texture2D
@export var sprite_back: Texture2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var area = $ClickableArea  # Reference the child Area2D
	area.input_event.connect(_on_area_input_event)  # Connect the signal

func _on_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and !is_flipped and get_parent().able_to_click_card:
		reveal_card()

func reveal_card():
	is_flipped = true
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0, 1), 0.2)
	await await get_tree().create_timer(0.2).timeout
	tween = create_tween()
	card_sprite.texture = sprite_front
	tween.tween_property(self, "scale", Vector2(1, 1), 0.2)
	get_parent().reveal_card_record(self)

func conceal_card():
	is_flipped = false
	card_sprite.texture = sprite_back

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

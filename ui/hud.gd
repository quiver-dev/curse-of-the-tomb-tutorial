extends CanvasLayer


var heart_sprite = preload("res://ui/heart_sprite.tscn")

@onready var heart_area = %HeartArea
@onready var coin_amount = %CoinAmount


func initialize(player: Player):
	player.on_health_changed.connect(handle_player_health_changed)
	GameManager.on_coins_changed.connect(handle_coins_changed)

	set_coin_amount(GameManager.coins)
	set_health_sprites(player.current_health)


func set_health_sprites(new_health: int):
	for child in heart_area.get_children():
		child.queue_free()

	for i in range(new_health):
		heart_area.add_child(heart_sprite.instantiate())


func set_coin_amount(new_coin_amount: int):
	coin_amount.text = str(new_coin_amount) + " coins"


func handle_player_health_changed(new_health: int):
	set_health_sprites(new_health)


func handle_coins_changed(new_coin_amount: int):
	set_coin_amount(new_coin_amount)

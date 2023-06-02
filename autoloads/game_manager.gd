extends Node


signal on_coins_changed(new_coin_amount: int)

var coins := 0:
	set(value):
		coins = value
		on_coins_changed.emit(coins)

extends Node


signal on_coins_changed(new_coin_amount: int)

var health := 3
var max_health := 3
var coins := 0:
	set(value):
		coins = value
		on_coins_changed.emit(coins)

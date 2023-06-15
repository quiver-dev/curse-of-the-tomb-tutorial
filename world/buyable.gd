extends Area2D


@export var upgrade: GameManager.Upgrades = GameManager.Upgrades.EXTRA_HEALTH_1
@export var display_name := ""
@export var cost := 0
@export var texture: Texture2D

var player: Player = null
var bought := false

@onready var animation_player = $AnimationPlayer
@onready var interact_label = $InteractLabel


func _ready() -> void:
	$UpgradeLabel.text = "%s - %d coins" % [display_name, cost]
	if texture != null:
		$Sprite2D.texture = texture

	if GameManager.has_upgrade(upgrade):
		animation_player.play("broken")
		_set_as_bought()


func buy():
	if not bought:
		var success = GameManager.buy_upgrade(upgrade, cost, player)

		if success:
			animation_player.play("smash")
			$Buy.play_at_random_pitch()
			_set_as_bought()


func _set_as_bought():
	bought = true
	interact_label.text = "Purchased"


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body
		interact_label.show()


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		player = null
		interact_label.hide()


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("interact") and player != null:
		buy()

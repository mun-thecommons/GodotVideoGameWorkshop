extends CanvasLayer

signal start_game

# Called when the node enters the scene tree for the first time.
func update_score(score):
	$ScoreLabel.text= str(score)

func showmessage(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()
	
func showgameover():
	showmessage("Game Over")
	await($MessageTimer.timeout)
	$MessageLabel.text = "The Common Goal"
	$MessageLabel.show()
	await(get_tree().create_timer(1.0).timeout)
	$Button.show()

func _on_button_pressed():
	$Button.hide()
	emit_signal("start_game")

func _on_message_timer_timeout():
	$MessageLabel.hide()

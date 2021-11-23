extends Popup

func _on_QuitButton_pressed():
	self.hide()
	$PopupDialog.hide()

func popup(bounds=Rect2(0, 0, 0, 0)):
	.popup()
	$PopupDialog.popup()

func _on_UpgradeBalloonsLevelButton_pressed():
	GlobalsPump.changeTypeBalloons(GlobalsPump.typeBalloon+1)
	GlobalsPump.changeAirMax(GlobalsPump.air_max*2)



func _on_UpgradeAirFlowButton_pressed():
	GlobalsPump.changeAirMax(float(GlobalsPump.air_max)/2)

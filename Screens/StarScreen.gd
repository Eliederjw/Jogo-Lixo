extends CanvasLayer

var number = 0

func check_number_of_coins(coins_collected, coins_total):
	if coins_collected < int(coins_total*0.9):
		number = 1
	if coins_collected >= int(coins_total*0.9) and coins_collected < int(coins_total):
		number = 2
	if coins_collected == int(coins_total):
		number = 3	
	set_number_of_stars()
	set_label(coins_collected, coins_total)

func set_number_of_stars():
	match number:
		1:
			$Star1.visible = true
		2:
			$Star1.visible = true
			$Star2.visible = true
		3:
			$Star1.visible = true
			$Star2.visible = true
			$Star3.visible = true

func set_label(coins : float, total : float):
	$Label.text = "Parabéns!"
			

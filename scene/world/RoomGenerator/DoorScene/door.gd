extends StaticBody2D
var desired_length = 6

func _ready() -> void:
	var door_size = $DoorSprite.texture.get_size()
	$DoorSprite.scale.x = desired_length / door_size.x
	$DoorSprite.scale.y = desired_length / door_size.y
	
	$DoorCollision.shape.size.x = desired_length
	$DoorCollision.shape.size.y = desired_length

extends KinematicBody


var spd = 50
var variation = rand_range(-0.25,0.5)
var coinrotate = 3

func _physics_process(delta):
	move_and_slide(Vector3(variation,variation,spd))
	rotation_degrees.y += coinrotate
	if transform.origin.z > 10:
		queue_free()

extends KinematicBody

var spd = 50
var variation = rand_range(-0.25,0.5)
var bombrotate = 3

func _physics_process(_delta):
	move_and_slide(Vector3(variation,variation,spd))
	rotation_degrees.y += bombrotate
	if transform.origin.z > 10:
		queue_free()

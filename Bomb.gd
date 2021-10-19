extends RigidBody

var velo = Vector3()

func _physics_process(_delta):
	
	set_linear_velocity(velo)

func _on_Area_body_entered(body):
	if body.is_in_group("Enemies"):
		get_tree().call_group("Gamestate", "enemy_killed")
		body.explode()
		queue_free()
		
	if body.is_in_group("Asteroid"):
		get_tree().call_group("Gamestate", "asteroid_hit")
		queue_free()

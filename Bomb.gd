extends RigidBody

var BombExplosion = load("res://BombExplosion.tscn")

var velo = Vector3()

func _physics_process(_delta):
	
	set_linear_velocity(velo)
	
func explode() -> void:
	$BombExplosion/Particles.emitting = true
	$MeshInstance.visible = false
	$Area/CollisionShape2.disabled = false
	yield(get_tree().create_timer(1.5),"timeout")
	queue_free()
	print("toc")

func _on_Area_body_entered(body):
	
	if body.is_in_group("Enemies"):
		get_tree().call_group("Gamestate", "enemy_killed")
		explode()
		body.explode()

	if body.is_in_group("Asteroid"):
		get_tree().call_group("Gamestate", "asteroid_hit")
		explode()

func _on_Timer_timeout():
	print("tic")
	explode()

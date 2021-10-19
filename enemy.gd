extends KinematicBody

var BulletEnemy = load("res://BulletEnemy.tscn")

var spd = rand_range(40,100)
var variation = rand_range(-1,1)
const explosion = 0.6
var explode_countdown = explosion
var velo = Vector3()
onready var gun  = $Gun

func _physics_process(_delta):
	move_and_slide(Vector3(variation,variation,spd))
	if transform.origin.z > 1:
		queue_free()

func explode() -> void:
	$Explosion/Particles.emitting = true
	$EnemyMesh.visible = false
	$CollisionShape.disabled = true
	yield(get_tree().create_timer(0.5),"timeout")
	queue_free()

func _on_Timer_timeout():
	var bullet = BulletEnemy.instance()
	get_parent().add_child(bullet)
	bullet.transform = global_transform
	bullet.velo = bullet.transform.basis.z * 225

func _on_Area_area_entered(area):
	if area.is_in_group("Player"):
		explode()

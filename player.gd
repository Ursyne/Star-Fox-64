extends KinematicBody

const MAXSPEED = 45
const ACCELERATION = 1.2
var inputVector = Vector3()
var velo = Vector3()

onready var guns  = [$Gun2,$Gun3]
onready var main = get_tree().current_scene
var Bullet = load("res://Bullet.tscn")
var Bomb = load("res://Bomb.tscn")
var cooldown = 0
const COOLDOWN = 8

func _physics_process(_delta):
	
	Shooting()

	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector.y = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	inputVector = inputVector.normalized()
	velo.x = move_toward(velo.x, inputVector.x * MAXSPEED, ACCELERATION)
	velo.y = move_toward(velo.y, inputVector.y * MAXSPEED, ACCELERATION)
	rotation_degrees.z = velo.x * -2
	rotation_degrees.x = velo.y / 2
	rotation_degrees.y = -velo.x / 2
	move_and_slide(velo)
	transform.origin.x = clamp(transform.origin.x, -14, 14)
	transform.origin.y = clamp(transform.origin.y, -9, 9)
	
	#Banking
	if Input.is_action_pressed("ui_page_up"):
		rotation_degrees.z = 100
		
	if Input.is_action_pressed("ui_page_down"):
		rotation_degrees.z = -100
	
	if Input.is_action_just_pressed("ui_home"):
		get_tree().call_group("Gamestate", "spinright")
		$Spin.play()
	if Input.is_action_just_pressed("ui_end"):
		get_tree().call_group("Gamestate", "spinright")
		$Spin.play()
	if Input.is_action_just_pressed("ui_cancel"):
		if Global.bombs >= 1:
			$Bomb.play()
			var bomb = Bomb.instance()
			main.add_child(bomb)
			bomb.transform = global_transform
			bomb.velo = bomb.transform.basis.z * -50
			get_tree().call_group("Gamestate", "bombs_down")

func Shooting():

	if Input.is_action_just_pressed("ui_accept"): 
		$Shoot.play()
		for i in guns:
			var bullet = Bullet.instance()
			main.add_child(bullet)
			bullet.transform = i.global_transform
			bullet.velo = bullet.transform.basis.z * -400

func _on_Area_body_entered(body):
		if body.is_in_group("Enemies"):
			get_tree().call_group("Gamestate", "player_damage")
		if body.is_in_group("Asteroid"):
			get_tree().call_group("Gamestate", "player_damage")
		if body.is_in_group("SilverRing"):
			get_tree().call_group("Gamestate", "rings_up")
		if body.is_in_group("GoldRing"):
			get_tree().call_group("Gamestate", "goldrings_up")
		if body.is_in_group("SmartBomb"):
			print("tick")
			get_tree().call_group("Gamestate", "bombs_up")
			
func explode() -> void:
	$Explosion/Particles.emitting = true
	$Area/CollisionShape.disabled = true
	yield(get_tree().create_timer(0.5),"timeout")
	queue_free()


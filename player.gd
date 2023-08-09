extends Area2D

signal hit

@export var speed= 600.0
var scrsize= Vector2.ZERO 

func _ready():
	scrsize = get_viewport_rect().size
	hide()

func _process(delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	
	if direction.length() > 0:
		direction = direction.normalized()
		#get_node("AnimatedSprite2D").play()
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop() 
		
	position += direction * speed * delta 
	position.x = clamp(position.x, 0 , scrsize.x)
	position.y= clamp(position.y, 0, scrsize.y)

	if direction.x != 0:
		$AnimatedSprite2D.animation = "right"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = direction.x <0
	elif direction.y !=0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v= direction.y >0

func start(new_position):
	position= new_position
	show()
	$CollisionShape2D.disabled = false 

func _on_body_entered(body):
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
	emit_signal("hit")
	
	

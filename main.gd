extends Node

@export var mob_scene: PackedScene
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

func new_game():
	score = 0
	$HUD.update_score(score)
	
	get_tree().call_group("mobs", "queue_free()")
	$Player.start($StartPosition.position) #fixed position
	
	$StartTimer.start()
	$Music.play()

	$HUD.showmessage("Get ready...")

	await($StartTimer.timeout)
	
	$ScoreTimer.start()
	$MobTimer.start()
	
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.showgameover()
	$Music.stop()
	$DeathSound.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mob_timer_timeout():
	var mobspawnlocation = $MobPath/MobSpawnLocation
	mobspawnlocation.progress_ratio = randf()
	
	var mob= mob_scene.instantiate()
	add_child(mob)
	
	mob.position = mobspawnlocation.position
	
	var direction = mobspawnlocation.rotation + PI/2
	direction += randf_range(-PI/4, +PI/4)
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = velocity.rotated(direction)


func _on_score_timer_timeout():
	score+= 1
	$HUD.update_score(score)

extends Node

@onready var player: Player:
	get: 
		if not player:
			player = get_tree().get_first_node_in_group("player")
		return player

@onready var skill_manager: SkillManager:
	get:
		if not skill_manager:
			skill_manager = skill_manager_resource.instantiate()
			add_child(skill_manager)
		return skill_manager

@onready var spawner_resource: Resource = preload("res://entities/spawner/spawner.tscn")
@onready var skill_manager_resource: Resource = preload("res://components/skill_manager/skill_manager.tscn")
@onready var sudo_resource: Resource = preload("res://entities/monsters/sudo.tscn")
@onready var kok_resource: Resource = preload("res://entities/monsters/kok.tscn")

var rand_x_positions: Array = [650, -650]
var rand_y_positions: Array = [400, -400]

var spawner: Spawner

var spawned_mini_boss: bool = false
var spawned_main_boss: bool = false

var general_spawn_timer: Timer
var batch_spawn_timer: Timer

#3 rows 10 columns for the batch formation
var batch_spawn_formation = {
	"rows": 3,
	"columns": 10,
	"offset": 50
}

func _ready() -> void:
	load_up_shiat()


func load_up_shiat():
	spawner = spawner_resource.instantiate()
	add_child(spawner)

	general_spawn_timer = Timer.new()
	general_spawn_timer.wait_time = .66
	general_spawn_timer.autostart = true
	general_spawn_timer.timeout.connect(_spawn_monster)
	add_child(general_spawn_timer)

	batch_spawn_timer = Timer.new()
	batch_spawn_timer.wait_time = 10
	batch_spawn_timer.autostart = true
	batch_spawn_timer.timeout.connect(_spawn_batch_monsters)
	add_child(batch_spawn_timer)

func restart():
	for child in get_tree().get_first_node_in_group("Stage").get_children():
		child.queue_free()

	general_spawn_timer.queue_free()
	batch_spawn_timer.queue_free()
	spawner.queue_free()
	skill_manager.queue_free()
	skill_manager = null
	get_tree().change_scene_to_file("res://scenes/arena/arena.tscn")
	load_up_shiat()
	get_tree().paused = false

func increase_spawn_speed():
	general_spawn_timer.wait_time *= .66
	batch_spawn_timer.wait_time *= .66

func game_over():
	var gover: Control = get_tree().get_first_node_in_group("GameOver")
	get_tree().paused = true
	gover.visible = true


func _spawn_batch_monsters():
	var location: Vector2 = _get_spawn_location()
	#spawn close to player for testing
	# location -= (player.global_position.distance_to(location) * player.global_position.direction_to(location)) / 2

	var direction = player.global_position.direction_to(location)
	var should_spawn_row = abs(direction.x) > abs(direction.y)

	var rows_to_spawn = batch_spawn_formation.get("rows") if should_spawn_row else batch_spawn_formation.get("columns")
	var cols_to_spawn = batch_spawn_formation.get("columns") if should_spawn_row else batch_spawn_formation.get("rows")

	var x_direction = 1 if direction.x > 0 else -1
	var y_direction = 1 if direction.y > 0 else -1

	for row in range(rows_to_spawn):
		for col in range(cols_to_spawn):
			var sprite_enum = GlobalSpriteAssets.get_random_monster_enum()
			var offset = location + (Vector2(row, col) * batch_spawn_formation.offset * skill_manager.monster_scale_multiplyer * Vector2(x_direction, y_direction))
			spawner._spawn_monster(offset, sprite_enum)


func _spawn_monster():
	var location: Vector2 = _get_spawn_location()
	spawner._spawn_random_monster(location)

func _get_spawn_location() -> Vector2:
	var option = randi_range(0, 1)
	if option == 0:
		var rand_x = randi_range(rand_x_positions[0], rand_x_positions[1])
		return player.position + Vector2(rand_x,rand_y_positions.pick_random())

	var rand_y = randi_range(rand_y_positions[0], rand_y_positions[1])
	return player.position + Vector2(rand_x_positions.pick_random(),rand_y)

func _spawn_boss(boss_resource: Resource) -> BossMonster:
	var boss_instance: BossMonster = boss_resource.instantiate()
	var location: Vector2 = _get_spawn_location()
	boss_instance.global_position = location
	spawner.add_child(boss_instance)
	return boss_instance
	
func _spawn_main_boss(boss_resource: Resource):
		var spawned_boss = _spawn_boss(boss_resource)
		spawned_boss.boss_died.connect(game_over)


func _process(_delta: float) -> void:
	if player and player.current_level >= 10 and not spawned_mini_boss:
		spawned_mini_boss = true
		_spawn_boss(sudo_resource)

	if player and player.current_level >= 20 and not spawned_main_boss:
		spawned_main_boss = true
		_spawn_main_boss(kok_resource)

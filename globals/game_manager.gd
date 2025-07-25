extends Node

@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var spawner_resource: Resource = preload("res://entities/spawner/spawner.tscn")
@onready var sudo_resource: Resource = preload("res://entities/monsters/sudo.tscn")
@onready var kok_resource: Resource = preload("res://entities/monsters/kok.tscn")

var rand_x_positions: Array = [650, -650]
var rand_y_positions: Array = [400, -400]

var spawner: Spawner

var spawned_mini_boss: bool = false
var spawned_main_boss: bool = false

var miniboss: Node2D
var boss: Node2D

var general_spawn_timer: Timer
var batch_spawn_timer: Timer

#3 rows 10 columns for the batch formation
var batch_spawn_formation = {
	"rows": 3,
	"columns": 10,
	"offset": 50
}

func _ready() -> void:
	print('loaded')
	miniboss = sudo_resource.instantiate()
	boss = kok_resource.instantiate()

	spawner = spawner_resource.instantiate()
	add_child(spawner)

	general_spawn_timer = Timer.new()
	general_spawn_timer.wait_time = 1
	general_spawn_timer.autostart = true
	general_spawn_timer.timeout.connect(_spawn_monster)
	add_child(general_spawn_timer)

	batch_spawn_timer = Timer.new()
	batch_spawn_timer.wait_time = 1
	batch_spawn_timer.autostart = true
	batch_spawn_timer.timeout.connect(_spawn_batch_monsters)
	add_child(batch_spawn_timer)



func game_over():
	pass

func _spawn_batch_monsters():
	var location: Vector2 = _get_spawn_location()
	location -= (player.global_position.distance_to(location) * player.global_position.direction_to(location)) / 2
	for row in range(batch_spawn_formation.get("rows")):
		for col in range(batch_spawn_formation.get("columns")):
			var sprite_enum = GlobalSpriteAssets.get_random_monster_enum()
			var offset = location + (Vector2(row, col) * batch_spawn_formation.offset)
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

func _spawn_boss(_boss: Node2D):
	var location: Vector2 = _get_spawn_location()
	_boss.global_position = location
	add_child(_boss)
	

func _process(_delta: float) -> void:
	if player.current_level >= 10 and not spawned_mini_boss:
		spawned_mini_boss = true
		_spawn_boss(miniboss)

	if player.current_level >= 20 and not spawned_main_boss:
		spawned_main_boss = true
		_spawn_boss(boss)

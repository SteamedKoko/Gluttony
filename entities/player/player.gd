class_name Player
extends CharacterBody2D

@export var speed: float = 250
@export var max_hp: float = 100
@export var damage_modifier: float = 1

@onready var current_exp: float = 0
@onready var current_level: float = 0
@onready var current_hp: float = 100

func get_movement():
    var input = Input.get_vector("left", "right", "up", "down")
    velocity = input * speed;


func _physics_process(_delta: float) -> void:
    get_movement()
    move_and_slide()

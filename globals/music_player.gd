extends Node

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer


@onready var main_track: Resource = preload("res://music/gym.mp3")
@onready var post_track: Resource = preload("res://music/mega_lower.mp3")


enum tracks {
	MAIN,
	POST
}

func _ready() -> void:
	audio_player.play()

func change_track(track: tracks):
	match track:
		tracks.MAIN:
			audio_player.stream = main_track
		tracks.POST:
			audio_player.stream = post_track

	audio_player.play()

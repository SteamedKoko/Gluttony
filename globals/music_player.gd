extends Node

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

enum tracks {
	MAIN,
	POST
}

func _ready() -> void:
	audio_player.play()

func change_track(track: tracks):
	var to_play = 'Main'
	match track:
		tracks.MAIN:
			to_play = 'Main'
		tracks.POST:
			to_play = 'Post'

	audio_player['parameters/switch_to_clip'] = to_play

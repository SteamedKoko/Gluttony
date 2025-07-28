extends Node2D

func _ready() -> void:
	MusicPlayer.change_track(MusicPlayer.tracks.MAIN)

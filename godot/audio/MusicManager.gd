extends Node

const VOLUME_REDUCTION = 20.0

@onready var layers = [
	preload("res://audio/music/InGame-Layer1(loop).ogg"),
	preload("res://audio/music/InGame-Layer2(loop).ogg"),
	preload("res://audio/music/InGame-Layer3(loop).ogg"),
	preload("res://audio/music/InGame-Layer4(loop).ogg")
]

var audio_stream_players:Array[AudioStreamPlayer]
var currently_playing:Array[int]

func _ready() -> void:
	for layer in layers:
		var audio_stream_player = AudioStreamPlayer.new()
		audio_stream_player.stream = layer
		audio_stream_player.volume_db = -VOLUME_REDUCTION
		audio_stream_player.process_mode = Node.PROCESS_MODE_ALWAYS
		audio_stream_players.append(audio_stream_player)
		add_child(audio_stream_player)
		
	play([0])

func play(layers:Array[int]) -> void:
	
	var current_position = _get_current_position()
	
	if currently_playing != null:
		# pause anything that is not contained by the
		# new composition
		for current in currently_playing:
			if not layers.has(current):
				_pause(current)
		
		# start playing anything that is not playing yet
		for to_play in layers:
			if not currently_playing.has(to_play):
				_play(to_play, current_position)
	
	currently_playing = layers
	
func _get_current_position() -> float:
	if not currently_playing.size() > 0:
		return 0.0
	else:
		var first_player = audio_stream_players[currently_playing[0]]
		return first_player.get_playback_position()
	
func _pause(layer:int) -> void:
	var player = audio_stream_players[layer]
	player.stream_paused = true
	
func _play(layer:int, position:float) -> void:
	var player = audio_stream_players[layer]
	player.stream_paused = false
	player.play(position)

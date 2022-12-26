extends Node


const NUM_PLAYERS: int = 8
const BUS: String = "SFX"

var _available_players: Array[AudioStreamPlayer] = []
var _audio_queue: Array[AudioStream] = []


func _ready() -> void:
	for _i in NUM_PLAYERS:
		var player: AudioStreamPlayer = AudioStreamPlayer.new()
		add_child(player)
		_available_players.append(player)
		player.finished.connect(func(): _on_stream_finished(player))
		player.bus = BUS


func _process(_delta: float) -> void:
	if not _audio_queue.is_empty() and not _available_players.is_empty():
		_available_players[0].stream = _audio_queue.pop_front()
		_available_players[0].play()
		_available_players.pop_front()


func _on_stream_finished(stream: AudioStreamPlayer) -> void:
	_available_players.append(stream)


func play(sound_res: AudioStream) -> void:
	_audio_queue.append(sound_res)

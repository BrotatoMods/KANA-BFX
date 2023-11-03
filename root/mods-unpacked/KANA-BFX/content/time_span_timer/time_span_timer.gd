extends Node


signal timeout(data_array)

var KANA_log_name := "KANA-TrainConductor"


func KANA_create_temp_timer(key: String, value: int, seconds: int) -> void:
	var timer := get_tree().create_timer(seconds)
	timer.connect("timeout", self, "_KANA_on_timer_timeout", [key, value, seconds])


func _KANA_on_timer_timeout(key: String, value: int, seconds: int) -> void:
	emit_signal("timeout", [key, value, seconds])

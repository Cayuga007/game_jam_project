extends Area2D

signal lost


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		lost.emit()

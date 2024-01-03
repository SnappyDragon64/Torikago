class_name SpikesComponent
extends Area2D


@export var damage := 10.0


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	if area is HealthComponent:
		area.hurt(damage)

extends Camera3D

@export var bullet_scene: PackedScene


func _process(delta) -> void:
	if Input.is_action_just_pressed("fire"):
		var mouse_pos = get_viewport().get_mouse_position()
		var ray_length = 100
		var from = project_ray_origin(mouse_pos)
		var to = from + project_ray_normal(mouse_pos) * ray_length
		var bullet = bullet_scene.instantiate()
		add_child(bullet)
		bullet.look_at(to)
		bullet.top_level = true
		bullet.fire(10)

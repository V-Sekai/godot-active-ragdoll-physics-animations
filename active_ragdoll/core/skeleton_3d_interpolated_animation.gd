extends Skeleton3D

@export_range(0.0, 1.0) var physics_interpolation: float = 0.7

@export var physics_skeleton: Skeleton3D
@export var animated_skeleton: Skeleton3D

var physics_bones

func _init():
	animate_physical_bones = false

func _ready():
	physics_bones = physics_skeleton.get_children().filter(func(x): return x is PhysicalBone3D)
	


func _physics_process(delta):
	for i in range(0, get_bone_count()):
		var animated_transform: Transform3D = (
			animated_skeleton.global_transform * animated_skeleton.get_bone_global_pose(i)
		)
		var physics_transform: Transform3D = (
			physics_skeleton.global_transform * physics_skeleton.get_bone_global_pose(i)
		)
		set_bone_global_pose_override(
			i,
			(
				global_transform.affine_inverse()
				* animated_transform.interpolate_with(physics_transform, physics_interpolation)
			),
			1.0,
			true
		)

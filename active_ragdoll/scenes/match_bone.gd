extends PhysicalBone3D

@export var target_skeleton: Skeleton3D


func _physics_process(delta):
	var target_transform: Transform3D = target_skeleton.get_bone_global_pose(get_bone_id())
	var transform: Transform3D = get_parent().get_bone_global_pose(get_bone_id())
	var difference: Basis = target_transform.basis * transform.basis.inverse()

	var torque = (4000.0 * difference.get_euler()) - (80.0 * angular_velocity)

	angular_velocity += torque * delta

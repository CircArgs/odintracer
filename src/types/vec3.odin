package types
import "core:math"
import "core:math/rand"
import "../utils"
Vector3 :: [4]f32

new_vector3 :: proc(x: f32 = 0.0, y: f32 = 0.0, z: f32 = 0.0) -> Vector3 {
	return Vector3{x, y, z, 0.0}
}

cross :: proc(a, b: Vector3) -> Vector3 {
	i := swizzle(a, 1, 2, 0, 3) * swizzle(b, 2, 0, 1, 3)
	j := swizzle(a, 2, 0, 1, 3) * swizzle(b, 1, 2, 0, 3)
	return i - j
}
dot :: #force_inline proc(a, b: Vector3) -> f32 {
	temp := a * b
	return temp.x + temp.y + temp.z
}
norm_sqd :: proc(v: Vector3) -> f32 {
	return dot(v, v)
}
norm :: proc(v: Vector3) -> f32 {

	return math.sqrt(norm_sqd(v))
}

normalize :: proc(v: Vector3) -> Vector3 {
	return v / norm(v)
}

rand_vector3::proc(min:f32 = -1.0, max: f32=1.0)->Vector3{
	return new_vector3(utils.random_range(min, max), utils.random_range(min, max), utils.random_range(min, max))
}
rand_unit_vector3::proc()->Vector3{
	return normalize(rand_vector3())
}

random_vector3_on_hemisphere::proc(normal: Vector3)->Vector3{

		test:=normalize(rand_vector3(-1, 1))
		if dot(test, normal)>0{
			return test
		}
		return -test
	
}

near_zero::proc(v: Vector3)->bool{
	s::1e-8
	return v.x<s&&v.y<s&&v.z<s
}

// reflect_vector3::proc(v: Vector3, normal: Vector3) -> Vector3{
// 	unit:=-normalize(v)
// 	return 2*normal-unit
// }

reflect_vector3::proc(v: Vector3, n: Vector3) -> Vector3 {
    return v - 2.0 * dot(v, n) * n
}

Point3 :: Vector3

new_point3 ::new_vector3
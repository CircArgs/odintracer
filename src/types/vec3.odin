package types
import "core:math"
import "core:math/rand"
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

rand_vector3::proc()->Vector3{
	return new_vector3(rand.float32(), rand.float32(), rand.float32())
}

Point3 :: Vector3

new_point3 ::new_vector3
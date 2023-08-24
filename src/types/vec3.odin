package types
import "core:math"
Vector3 :: [4]f32

cross :: proc(a, b: Vector3) -> Vector3 {
	i := swizzle(a, 1, 2, 0, 3) * swizzle(b, 2, 0, 1, 3)
	j := swizzle(a, 2, 0, 1, 3) * swizzle(b, 1, 2, 0, 3)
	return i - j
}
dot :: #force_inline proc(a, b: Vector3) -> f32 {
	temp:=a*b
	return temp.x+temp.y+temp.z
}
norm_sqd :: proc(v: Vector3)->f32{
	return dot(v, v)
}
norm :: proc(v: Vector3)->f32{

	return math.sqrt(norm_sqd(v))
}

normalize :: proc(v: Vector3)->Vector3{
	return v/norm(v)
}


Point3 :: Vector3
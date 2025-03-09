package types


Lambertian :: struct {
	using mat: Material,
	albedo:    Color3,
}

new_lambertian :: proc(color: Color3) -> ^Lambertian {
	ret := new(Lambertian)
	ret.variant = ret
	ret.albedo = color
	return ret
}

scatter_lambertian :: proc(lambertian: Lambertian, ray: Ray, hit: Hit) -> (Color3, Ray) {
	scatter_direction := hit.normal + rand_unit_vector3()
	if near_zero(scatter_direction) {
		scatter_direction = hit.normal
	}
	scattered := Ray {
		origin    = hit.point,
		direction = scatter_direction,
	}
	return lambertian.albedo, scattered
}

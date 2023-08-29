package types


Metal :: struct {
	using mat: Material,
	albedo:    Color3,
}

new_metal :: proc(color: Color3) -> ^Metal {
	ret := new(Metal)
	ret.variant = ret
	ret.albedo = color
    return ret
}

scatter_metal :: proc(metal: Metal, ray: Ray, hit: Hit) -> (Color3, Ray) {
	scatter_direction := reflect_vector3(ray.direction, hit.normal)
    if near_zero(scatter_direction){
        scatter_direction=hit.normal
    }
	scattered := Ray {
		origin    = hit.point,
		direction = scatter_direction,
	}
	return metal.albedo, scattered
}

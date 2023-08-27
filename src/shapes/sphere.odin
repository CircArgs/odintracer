package shapes

import "core:math"
import "core:fmt"
import "../types"

Sphere :: struct {
	using hittable: Hittable,
	radius:         f32,
	center:         types.Point3,
}

hit_sphere :: proc(s: Sphere, r: types.Ray, interval: types.Interval) -> Maybe(types.Hit) {
	oc := r.origin - s.center
	a := types.norm_sqd(r.direction)
	b_h := types.dot(r.direction, oc)
	c := types.norm_sqd(oc) - s.radius * s.radius
	discriminant := b_h * b_h - a * c

	if discriminant < 0.0 {
		return nil
	}

	sqrt_discriminant := math.sqrt(discriminant)
	t1 := (-b_h - sqrt_discriminant) / a
	t2 := (-b_h + sqrt_discriminant) / a

	if t1 > t2 {
		t1, t2 = t2, t1
	}

	if types.interval_contains(interval, t1) {} else if types.interval_contains(interval, t2) {
		t1, t2 = t2, t1
	} else {
		return nil
	}


	hit_point := r.origin + t1 * r.direction
	normal := (hit_point - s.center) / s.radius
    // fmt.println("norm", normal)
	outward := types.dot(normal, r.direction) > 0.0
	return types.Hit{distance = t1, point = hit_point, normal = normal, outward = outward}
}

new_sphere :: proc(center: types.Point3, radius: f32) -> ^Sphere {
	h := new(Sphere)
	h.variant = h
	h.center = center
	h.radius = radius
	return h
}

package shapes

import "core:math"
import "core:fmt"
import "../types"

Sphere ::struct{
    radius: f32,
    center: types.Point3,
}

hit_sphere::proc(s: Sphere, r: types.Ray) -> Maybe(types.Hit) {
    oc := r.origin - s.center
    a := types.norm_sqd(r.direction)
    b := 2.0 * types.dot(r.direction, oc)
    c := types.norm_sqd(oc) - s.radius * s.radius
    discriminant := b * b - 4.0 * a * c
    
    if discriminant < 0.0 {
        return nil
    }
    
    sqrt_discriminant := math.sqrt(discriminant)
    t1 := (-b - sqrt_discriminant) / (2.0 * a)
    t2 := (-b + sqrt_discriminant) / (2.0 * a)
    
    if t1 > t2 {
        t1, t2 = t2, t1
    }
    
    hit_point := r.origin + t1 * r.direction
    normal := (hit_point - s.center) / s.radius
    
    return types.Hit{distance= t1, point= hit_point, normal= normal}
}
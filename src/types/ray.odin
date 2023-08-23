package types

Ray :: struct{
    origin: Point3,
    direction: Vector3
}

at :: proc(ray: Ray, t: f32)->Point3{
    return ray.origin+ray.direction*t
}
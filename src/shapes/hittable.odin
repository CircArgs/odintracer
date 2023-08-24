package shapes
import "../types"

Hittable::struct{
    variant: union{^Sphere}
}

hit_hittable :: proc(h:Hittable, r: types.Ray, interval: types.Interval)->Maybe(types.Hit){
    switch hittable in h.variant{
        case ^Sphere:
            return hit_sphere(hittable^, r, interval)
    }
    return nil
}

hit :: proc{hit_hittable, hit_world}
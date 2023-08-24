package shapes
import "../types"

Hittable::struct{
    variant: union{^Sphere}
}

hit_hittable :: proc(h:Hittable, r: types.Ray)->Maybe(types.Hit){
    switch hittable in h.variant{
        case ^Sphere:
            return hit_sphere(hittable^, r)
    }
    return nil
}

hit :: proc{hit_hittable, hit_world}
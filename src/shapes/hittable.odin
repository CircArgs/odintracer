package shapes
import "../types"

Hittable::struct{
    variant: union{^Sphere}
}

hit :: proc(h:Hittable, r: types.Ray)->Maybe(types.Hit){
    switch hittable in h.variant{
        case ^Sphere:
            return hit_sphere(hittable^, r)
    }
    return nil
}

// new::proc{new_sphere}
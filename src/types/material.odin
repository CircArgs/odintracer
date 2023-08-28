package types

import "core:fmt"

Material::struct{
    variant: union{^Lambertian}
}

scatter::proc(ray: Ray, hit: Hit)->(Color3, Ray){
    switch mat in hit.material^.variant{
        case ^Lambertian:
            return scatter_lambertian(mat^, ray, hit)
    }
    return Color3{}, Ray{}
}
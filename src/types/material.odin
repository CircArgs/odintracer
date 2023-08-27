package types

Material::struct{
    variant: union{^Lambertian}
}

scatter::proc(material: ^Material, ray: Ray, hit: Hit)->(Color3, Ray){
    switch mat in material^.variant{
        case ^Lambertian:
            return scatter_lambertian(mat^, ray, hit)
    }
    return Color3{}, Ray{}
}
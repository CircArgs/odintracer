package main

import "core:fmt"
import "core:io"
import "core:os"
import "core:bufio"
import "core:math"
import "types"
import "shapes"

main :: proc() {
	f, err := os.open("image.ppm", mode = os.O_WRONLY)
	if err != os.ERROR_NONE {
		fmt.eprintln("Could not open file for writing", err)
		os.exit(2)
	}
	defer os.close(f)
    material_ground := types.new_lambertian(types.Color3{0.8, 0.8, 0.0});
    material_center := types.new_lambertian(types.Color3{0.7, 0.3, 0.3});
	material_left := types.new_metal(types.Color3{0.8, 0.8, 0.8});
	material_right := types.new_metal(types.Color3{0.8, 0.6, 0.2});
	world := shapes.World{}
	append(&world.hittables, shapes.new_sphere(types.new_point3(z=-1), 0.5, material_center))
	append(&world.hittables, shapes.new_sphere(types.new_point3(x=-1.0, z=-1), 0.5, material_left))
	append(&world.hittables, shapes.new_sphere(types.new_point3(x=2, z=-1), 0.5, material_right))
	append(&world.hittables, shapes.new_sphere(types.new_point3(y=-100.5, z=-1), 100, material_ground))

	camera:=new_camera(aspect_ratio=16.0/9.0, image_width=400, aa=100)
	render(camera, world, f, max_hits = 50)
}

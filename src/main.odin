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

	world := shapes.World{}
	append(&world.hittables, shapes.new_sphere(types.new_point3(z=-1), 0.5))
	append(&world.hittables, shapes.new_sphere(types.new_point3(y=-100.5, z=-1), 100))

	camera:=new_camera(aspect_ratio=16.0/9.0, image_width=400, aa=25)
	render(camera, world, f)

}

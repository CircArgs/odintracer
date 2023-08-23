package main

import "core:fmt"
import "core:io"
import "core:os"
import "core:bufio"
import "core:math"
import "types"




print_progress :: proc(p: f32) {
	pcnt := u32(p * 100)
	for i in 0 ..= pcnt {
		fmt.print('=')
	}
	fmt.printf(" {}%%\r", pcnt)
}

ray_color :: proc(ray: types.Ray) -> types.Color3 {
	unit:=types.normalize(ray.direction)
	a:=.5*(unit.y+1)
	return (1-a)*(types.Color3{1, 1, 1})+a*types.Color3{.5, .7, 1}
}

main :: proc() {
	using types
	aspect_ratio :f32= 16.0 / 9.0
	image_width := 256
	image_height := int(max(1.0, f32(image_width) / aspect_ratio))
	tot_pixels := image_height * image_width
	viewport_height :f32= 2.0
	viewport_width := viewport_height * f32(image_width)/f32(image_height)
	focal_length :f32= 1.0
	camera_center := types.Point3{}
	viewport_u := types.Vector3{viewport_width, 0, 0, 0}
	viewport_v := types.Vector3{0, -viewport_height, 0, 0}
	
	pixel_delta_u := viewport_u / f32(image_width)
	pixel_delta_v := viewport_v / f32(image_height)
	
	camera_direction := types.normalize(types.cross(viewport_u, viewport_v))
	viewport_ul :=
		camera_center + camera_direction * focal_length - 0.5 * viewport_u - 0.5 * viewport_v
	pixel00_loc := viewport_ul + 0.5 * (pixel_delta_u + pixel_delta_v)

	f, err := os.open("image.ppm", mode = os.O_WRONLY)
	if err != os.ERROR_NONE {
		fmt.eprintln("Could not open file for writing", err)
		os.exit(2)
	}
	defer os.close(f)

	fmt.fprintf(f, "P3\n{} {}\n255\n", image_width, image_height)

	for j in 0 ..< image_height {
		j:=f32(j)
		for i in 0 ..< image_width {
			i:=f32(i)
			pixel_center := pixel00_loc + i * pixel_delta_u + j * pixel_delta_v
			ray_direction := pixel_center - camera_center
			r := Ray {
				origin    = camera_center,
				direction = ray_direction,
			}
			pixel_color := ray_color(r)
			write_color(pixel_color, f)
		}
		print_progress(j / f32(image_height))
	}
}

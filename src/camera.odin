package main


import "core:os"
import "core:fmt"
import "types"
import "shapes"
import "utils"

Camera :: struct {
	aspect_ratio:  f32,
	aa:            u32,
	image_width:   u32,
	image_height:  u32,
	center:        types.Point3,
	pixel00_loc:   types.Point3,
	pixel_delta_u: types.Vector3,
	pixel_delta_v: types.Vector3,
}

new_camera :: proc(
	aspect_ratio: f32 = 1.0,
	image_width: u32 = 100,
	aa: u32 = 10,
) -> (
	ret: Camera,
) {
	ret.aspect_ratio = aspect_ratio
	ret.image_width = image_width
	ret.aa = aa
	ret.image_height = u32(f32(image_width) / aspect_ratio)

	ret.image_height = ret.image_height < 1 ? 1 : ret.image_height

	ret.center = types.new_point3()

	focal_length: f32 = 1.0
	viewport_height: f32 = 2.0
	viewport_width: f32 = viewport_height * f32(image_width) / f32(ret.image_height)


	viewport_u := types.new_vector3(x = viewport_width)
	viewport_v := types.new_vector3(y = -viewport_height)

	ret.pixel_delta_u = viewport_u / f32(ret.image_width)
	ret.pixel_delta_v = viewport_v / f32(ret.image_height)

	camera_direction := types.normalize(types.cross(viewport_u, viewport_v))
	viewport_ul :=
		ret.center + camera_direction * focal_length - 0.5 * viewport_u - 0.5 * viewport_v
	ret.pixel00_loc = viewport_ul + 0.5 * (ret.pixel_delta_u + ret.pixel_delta_v)
	return
}

ray_color :: proc(
	ray: types.Ray,
	world: shapes.World,
	max_hits: u32,
	hits: u32 = 0,
) -> types.Color3 {
	if hits < max_hits {
		hit := shapes.hit(world, ray, types.default_interval())
		if hit != nil {
			attenuation, new_ray := types.scatter(ray, hit.?)
			return attenuation*ray_color(new_ray, world, max_hits, hits + 1) * 0.5
		}
    }
	unit := types.normalize(ray.direction)
	a := .5 * (unit.y + 1)
	return (1 - a) * (types.Color3{1, 1, 1}) + a * types.Color3{.5, .7, 1}
}

render :: proc(camera: Camera, world: shapes.World, handle: os.Handle, max_hits: u32) {
	fmt.fprintf(handle, "P3\n{} {}\n255\n", camera.image_width, camera.image_height)
	for j in 0 ..< camera.image_height {
		j := f32(j)
		for i in 0 ..< camera.image_width {
			i := f32(i)
			pixel_center :=
				camera.pixel00_loc + i * camera.pixel_delta_u + j * camera.pixel_delta_v
			ray_direction := pixel_center - camera.center
			r := types.Ray {
				origin    = camera.center,
				direction = ray_direction,
			}

			pixel_color := ray_color(r, world, max_hits)
			for anti_alias in 0 ..< camera.aa {
				r.direction =
					ray_direction +
					(utils.random_range(-.5, .5)) * camera.pixel_delta_u +
					(utils.random_range(-.5, .5)) * camera.pixel_delta_v
				pixel_color += ray_color(r, world, max_hits)
			}

			pixel_color /= f32(camera.aa + 1)
			types.write_color(pixel_color, handle)
		}
		utils.print_progress(j / f32(camera.image_height))
	}
}
